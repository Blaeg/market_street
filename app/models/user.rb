# == USERS DOCUMENTATION
#
# The users table represents...  USERS!!!
#
# When a user signs up to the application they can be put into several states and have
# different requirements depending on how they signed up.
#

##

# == Schema Information
#
# Table name: users
#
#  id                :integer(4)      not null, primary key
#  first_name        :string(255)
#  last_name         :string(255)
#  email             :string(255)
#  state             :string(255)
#  account_id        :integer(4)
#  customer_cim_id   :string(255)
#  password_salt     :string(255)
#  crypted_password  :string(255)
#  perishable_token  :string(255)
#  persistence_token :string(255)
#  access_token      :string(255)
#  comments_count    :integer(4)      default(0)
#  created_at        :datetime
#  updated_at        :datetime
#

class User < ActiveRecord::Base
  include TransactionAccountable

  require_dependency 'user/states'
  include User::States

  require_dependency 'user/user_cim'
  include User::UserCim

  acts_as_authentic do |config|
    config.validate_email_field
    config.validates_length_of_password_field_options( :minimum => 6, :on => :update, :if => :password_changed? )

    # So that Authlogic will not use the LOWER() function when checking login, allowing for benefit of column index.
    config.validates_uniqueness_of_login_field_options :case_sensitive => true
    config.validates_uniqueness_of_email_field_options :case_sensitive => true

    config.validate_login_field = true;
    config.validate_email_field = true;
  end

  before_validation :sanitize_data
  before_validation :before_validation_on_create, :on => :create
  before_create :start_store_credits
  after_create  :set_referral_registered_at

  belongs_to :account

  has_many  :referrals, class_name: 'Referral', foreign_key: 'referring_user_id' # people you have tried to referred
  has_one   :referree,  class_name: 'Referral', foreign_key: 'referral_user_id' # person who referred you

  has_one     :store_credit
  has_many    :orders
  has_many    :comments
  has_many    :customer_service_comments, as:         :commentable,
                                          class_name: 'Comment'
  has_many    :shipments, :through => :orders
  has_many    :finished_orders,           -> { where(state: ['complete', 'paid']) },  class_name: 'Order'
  has_many    :completed_orders,          -> { where(state: 'complete') },            class_name: 'Order'

  has_many    :phones,          dependent: :destroy,       as: :phoneable
  has_one     :primary_phone, -> { where(primary: true) }, as: :phoneable, class_name: 'Phone'

  has_many    :addresses,       dependent: :destroy,       as: :addressable

  has_one     :default_billing_address,   -> { where(billing_default: true, active: true) },
                                          as:         :addressable,
                                          class_name: 'Address'

  has_many    :billing_addresses,         -> { where(active: true) },
                                          as:         :addressable,
                                          class_name: 'Address'

  has_one     :default_shipping_address,  -> { where(default: true, active: true) },
                                          as:         :addressable,
                                          class_name: 'Address'

  has_many     :shipping_addresses,       -> { where(active: true) },
                                          as:         :addressable,
                                          class_name: 'Address'

  has_many    :user_roles,                dependent: :destroy
  has_many    :roles,                     through: :user_roles

  #cart
  has_many    :carts,                     dependent: :destroy
  has_many    :wish_items,                dependent: :destroy
  
  has_many    :payment_profiles
  has_many    :transaction_ledgers, as: :accountable

  has_many    :return_authorizations
  has_many    :authored_return_authorizations, class_name: 'ReturnAuthorization', foreign_key: 'author_id'

  validates :first_name,  presence: true, if: :registered_user?,
                          format:   { with: CustomValidators::Names.name_validator },
                          length:   { maximum: 30 }
  validates :last_name,   :presence => true, :if => :registered_user?,
                          :format   => { :with => CustomValidators::Names.name_validator },
                          :length => { :maximum => 35 }
  validates :email,       :presence => true,
                          :uniqueness => true,##  This should be done at the DB this is too expensive in rails
                          :format   => { :with => CustomValidators::Emails.email_validator },
                          :length => { :maximum => 255 }

  accepts_nested_attributes_for :addresses, :user_roles
  accepts_nested_attributes_for :phones, :reject_if => lambda { |t| ( t['display_number'].gsub(/\D+/, '').blank?) }
  accepts_nested_attributes_for :customer_service_comments, :reject_if => proc { |attributes| attributes['note'].strip.blank? }

  # returns true or false if the user has a role or not
  #
  # @param [String] role name the user should have
  # @return [ Boolean ]
  def role?(role_name)
    roles.any? {|r| r.name == role_name.to_s}
  end

  # returns true or false if the user is an admin or not
  #
  # @param [none]
  # @return [ Boolean ]
  def admin?
    role?(:administrator) || role?(:super_administrator)
  end

  # returns true or false if the user is a super admin or not
  # FYI your IT staff might be an admin but your CTO and IT director is a super admin
  #
  # @param [none]
  # @return [ Boolean ]
  def super_admin?
    role?(:super_administrator)
  end

  # returns your last cart or nil
  #
  # @param [none]
  # @return [ Cart ]
  def current_cart
    carts.last
  end

  ##  This method will one day grow into the products a user most likely likes.
  #   Storing a list of product ids vs cron each night might be the most efficent mode for this method to work.
  def might_be_interested_in_these_products
    Product.limit(4)
  end

  # Returns the default billing address if it exists.   otherwise returns the shipping address
  #
  # @param [none]
  # @return [ Address ]
  def billing_address
    default_billing_address ? default_billing_address : shipping_address
  end

  # Returns the default shipping address if it exists.   otherwise returns the first shipping address
  #
  # @param [none]
  # @return [ Address ]
  def shipping_address
    default_shipping_address ? default_shipping_address : shipping_addresses.first
  end

  # returns true or false if the user is a registered user or not
  #
  # @param [none]
  # @return [ Boolean ]
  def registered_user?
    active?
  end

  # gives the user's first and last name if available, otherwise returns the users email
  #
  # @param [none]
  # @return [ String ]
  def name
    (first_name? && last_name?) ? [first_name.capitalize, last_name.capitalize ].join(" ") : email
  end

  # sanitizes the saving of data.  removes white space and assigns a free account type if one doesn't exist
  #
  # @param  [ none ]
  # @return [ none ]
  def sanitize_data
    self.email      = self.email.strip.downcase       unless email.blank?
    self.first_name = self.first_name.strip.capitalize  unless first_name.nil?
    self.last_name  = self.last_name.strip.capitalize   unless last_name.nil?

    ## CHANGE THIS IF YOU HAVE DIFFERENT ACCOUNT TYPES
    self.account = Account.first if account_id.nil?
  end

  # name and email string for the user
  # ex. '"John Wayne" "jwayne@badboy.com"'
  #
  # @param  [ none ]
  # @return [ String ]
  def email_address_with_name
    "\"#{name}\" <#{email}>"
  end

  # place holder method for creating cim profiles for recurring billing
  #
  # @param  [ none ]
  # @return [ String ] CIM id returned from the gateway
  def get_cim_profile
    return customer_cim_id if customer_cim_id
    create_cim_profile
    customer_cim_id
  end

  # name and first line of address (used by credit card gateway to descript the merchant)
  #
  # @param  [ none ]
  # @return [ String ] name and first line of address
  def merchant_description
    [name, default_shipping_address.try(:address_lines)].compact.join(', ')
  end

  # Find users that have signed up for the subscription
  #
  # @params [ none ]
  # @return [ Arel ]
  def self.find_subscription_users
    where('account_id NOT IN (?)', Account::FREE_ACCOUNT_IDS )
  end

  # include addresses in Find
  #
  # @params [ none ]
  # @return [ Arel ]
  def include_default_addresses
    includes([:default_billing_address, :default_shipping_address, :account])
  end

  # paginated results from the admin User grid
  #
  # @param [Optional params]
  # @return [ Array[User] ]
  def self.admin_grid(params = {})
    includes(:roles).first_name_filter(params[:first_name]).
                     last_name_filter(params[:last_name]).
                     email_filter(params[:email])
  end

  def number_of_finished_orders
    finished_orders.count
  end

  def number_of_finished_orders_at(at)
    finished_orders.select{|o| o.completed_at < at }.size
  end

  def store_credit_amount
    store_credit.amount
  end

  private

  def self.first_name_filter(first_name)
    first_name.present? ? where("users.first_name LIKE ?", "#{first_name}%") : all
  end

  def self.last_name_filter(last_name)
    last_name.present? ? where("users.last_name LIKE ?", "#{last_name}%") : all
  end

  def self.email_filter(email)
    email.present? ? where("users.email LIKE ?", "#{email}%") : all
  end

  def set_referral_registered_at
    if refer_al = Referral.find_by_email(email)
      refer_al.set_referral_user(id)
    end
  end

  def start_store_credits
    self.store_credit = StoreCredit.new(:amount => 0.0, :user => self)
  end

  def password_required?
    self.crypted_password.blank?
  end

  def user_profile
    return {:merchant_customer_id => id, :email => email, :description => merchant_description}
  end

  def before_validation_on_create
    self.access_token = SecureRandom::hex(9+rand(6)) if access_token.nil?
  end
end
