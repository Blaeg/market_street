# == Class Info
#
#  The checkout process starts on the http://www.yoursite.com/shopping/cart_items page.
#
#  Clicking the "checkout button" Starts the process.  This action takes all the active
#  cart\_items in the "shopping\_cart" state and saves them as order\_items.  Each order
#  item represents one AND ONLY ONE, I repeat ONLY ONE, item.  There is no quantity field.
#  It is IMPOSSIBLE to have a quantity field and do returns correctly.  DO NOT CHANGE THIS!
#
#  At this point the Order is in an "in\_progress" state.  Immediately the user is asked to
#  enter their credentials for security reasons (unless they logged in with 20 minutes).
#  Now the user is in the checkout workflow.  The basic workflow is determined by the
#  Shopping::BaseController.next\_form(order) method.  During the checkout the user is directed
#  to the Shopping::OrdersController.index method.  The Shopping::BaseController.next\_form(order)
#  method is called and the next form to show is redirected to unless they are on the last step.
#
#  *  First it makes sure the Creditcard number passes luhn validation/date validation.
#  *  Second there is a call to the app to verify the price is correct.
#     (BTW: this could change because the user has multiple tabs open in the browser)
#  *  Then a call is made with Active Merchant to authorize the creditcard.  If all goes well the
#     transaction will go through and the card is charged when the item is shipped.
#
#  The order will now be in the 'paid' state.  Each order item will also be marked as "paid".


# == Schema Information
#
# Table name: orders
#
#  id              :integer(4)      not null, primary key
#  number          :string(255)
#  ip_address      :string(255)
#  email           :string(255)
#  state           :string(255)
#  user_id         :integer(4)
#  bill_address_id :integer(4)
#  ship_address_id :integer(4)
#  coupon_id       :integer(4)
#  active          :boolean(1)      default(TRUE), not null
#  shipped         :boolean(1)      default(FALSE), not null
#  calculated_at   :datetime
#  completed_at    :datetime
#  created_at      :datetime
#  updated_at      :datetime
#  credited_amount :decimal(8, 2)   default(0.0)

class Order < ActiveRecord::Base
  require_dependency 'order/calculator'
  require_dependency 'order/states'
  require_dependency 'order/invoice_manager'
  include Order::Calculator
  include Order::States  
  include Order::InvoiceManager

  extend FriendlyId
  friendly_id :number

  has_many   :order_items, :dependent => :destroy
  has_many   :shipments
  
  has_many   :invoices
  has_many   :completed_invoices,   -> { where(state: ['authorized', 'paid']) },  class_name: 'Invoice'
  has_many   :authorized_invoices,  -> { where(state: 'authorized') },      class_name: 'Invoice'
  has_many   :paid_invoices      ,  -> { where(state: 'paid') },            class_name: 'Invoice'
  has_many   :canceled_invoices  , ->  { where(state: 'canceled') }  ,     class_name: 'Invoice'
  
  has_many   :return_authorizations
  has_many   :comments, as: :commentable

  belongs_to :user
  belongs_to :coupon
  belongs_to :ship_address, class_name: 'Address'
  belongs_to :bill_address, class_name: 'Address'

  before_validation :set_email, :set_number
  after_create      :save_order_number
  #before_save       :update_tax_rates

  attr_accessor :total, :sub_total, :deal_amount, :taxed_total, :deal_time
  accepts_nested_attributes_for :order_items

  validates :number,      :presence => true
  validates :user_id,     :presence => true
  validates :email,       :presence => true,
    :format   => { :with => CustomValidators::Emails.email_validator }
  
  scope :active_session_carts,  -> (user, session_id) { where(state: :active, user_id: user, session_id: session_id) }
  scope :between, -> (start_time, end_time) { where("orders.completed_at >= ? AND orders.completed_at <= ?", start_time, end_time) }
  scope :finished, -> { where({:orders => { :state => ['complete', 'paid']}})}
  scope :order_by_completion, order('orders.completed_at asc')
  scope :find_customer_details, includes([:completed_invoices, :invoices])
  
  NUMBER_SEED     = 1001001001000
  CHARACTERS_SEED = 21

  delegate :name, :to => :user

  #todo:move decorator
  def display_completed_at(format = :us_date)
    completed_at ? I18n.localize(completed_at, :format => format) : 'Not Finished.'
  end

  def cancel_unshipped_order(invoice)
    transaction do
      invoice.cancel_authorized_payment
      cancel!
    end
  end

  # def add_cart_item( item, state_id = nil)
  #   self.save! if self.new_record?
  #   tax_rate_id = state_id ? item.variant.product.tax_rate(state_id) : nil
  #   oi =  OrderItem.create(
  #       :order        => self,
  #       :variant_id   => item.variant.id,
  #       :price        => item.variant.price,
  #       :quantity     => item.quantity,
  #       :shipping_amount => item.shipping_amount,
  #       :tax_rate_id  => tax_rate_id)
  
  def order_complete!
    self.complete!
    self.completed_at = Time.zone.now
    update_inventory
  end

  # This returns a hash where product_type_id is the key and an Array of prices are the values.
  #   This method is specifically used for Deal.rb
  #
  #   So for example you have a shirt that has product_type of "shirt" which is a child of product_type "clothing"
  #     "shirt" product_type_id    == 1
  #     "clothing" product_type_id == 2
  #
  #   So the order_items are a shirt ($40.00) and two other order_items that are just clothing product_type_id ($50.00 & $60.00)
  #
  #      order.number_of_a_given_product_type => {1 => [40.00], 2 => [40.00, 50.00, 60.00]}
  #
  #   Hence a deal is given out for a given product_type.
  #      buy 2 pieces of clothing get one free would work and the free item would be $40.00
  #      buy 2 shirts get one free would Not work and hence NO DEAL
  #
  # @return [Hash] This returns a hash of { product_type_id => [price, price], product_type2_id => [price, price, price]}
  def number_of_a_given_product_type
     return_hash = order_items.inject({}) do |hash, oi|
       oi.product_type_ids.each do |product_type_id|
         hash[product_type_id] ||= []
         hash[product_type_id] << oi.price
       end
       hash
     end
     return_hash
  end
  
  def self.include_checkout_objects
    includes([{:ship_address => :state},
              {:bill_address => :state},
              {:order_items =>
                {:variant =>
                  {:product => :images }}}])
  end

  def shipments_count
    order_items.map{|item| item.shipments.count}.sum
  end

  # def remove_user_store_credits
  #   user.store_credit.remove_credit(amount_to_credit) if amount_to_credit > 0.0
  # end

  # def create_shipments_with_order_item_ids(order_item_ids)
  #   self.order_items.find(order_item_ids).map do |order_item|
  #     shipment = Shipment.new(:address_id => self.ship_address_id,
  #                             :order_id => self.id )          
  #     shipment.order_items.push(order_item) if order_item.paid?
  #     binding.pry
  #     shipment.save!
  #     shipment.prepare! if shipment.order_items.size > 0
  #   end.any?
  # end

  # add the variant to the order items in the order, normally called at order creation
  #
  # @param [Variant] variant to add
  # @param [Integer] quantity to add to the order
  # @param [Optional Integer] state_id (for taxes) to assign to the order_item
  # @return [none]
  def add_items(variant, quantity, state_id = nil)
    self.save! if self.new_record?
    self.order_items.create(:variant_id => variant.id, 
                            :price => variant.price, 
                            :quantity => quantity)    
  end

  # remove the variant from the order items in the order
  #
  # @param [Variant] variant to add
  # @param [Integer] final quantity that should be in the order
  # @return [none]
  # def remove_items(variant, final_quantity)
  #   self.order_items.select{|l| l.variant_id == variant.id }.each do |l|      
  #     if final_quantity == 0
  #       l.destroy
  #     else
  #       l.update_attributes(:quantity => final_quantity)
  #     end      
  #   end
  #   self.order_items.reload
  # end

  ## determines the order id from the order.number
  #
  # @param [String]  represents the order.number
  # @return [Integer] id of the order to find
  def self.id_from_number(num)
    num.to_i(CHARACTERS_SEED) - NUMBER_SEED
  end

  ## finds the Order from the orders number.  Is more optimal than the normal rails find by id
  #      because if calculates the order's id which is indexed
  #
  # @param [String]  represents the order.number
  # @return [Order]
  def self.find_by_number(num)
    find(id_from_number(num))##  now we can search by id which should be much faster
  end

  ## This method is called when the order transitions to paid
  #   it will add the number of variants pending to be sent to the customer
  #
  # @param none
  # @return [none]
  def update_inventory
    self.order_items.each { |item| item.variant.add_pending_to_customer }
  end

  def variant_ids
    order_items.map(&:variant_id)
  end

  def has_shipment?
    order_items.any?{|item| item.shipments.count > 0 }    
  end

  private

  def set_email
    self.email = user.email if user_id
  end

  def set_number
    return set_order_number if self.id
    self.number = (Time.now.to_i).to_s(CHARACTERS_SEED)## fake number for friendly_id validator
  end

  def set_order_number
    # o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    # string = (0...50).map { o[rand(o.length)] }.join
    self.number = (NUMBER_SEED + id).to_s(CHARACTERS_SEED)
  end

  def save_order_number
    set_order_number
    save
  end
end