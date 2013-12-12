# == Schema Information
#
# Table name: products
#
#  id                   :integer(4)      not null, primary key
#  name                 :string(255)     not null
#  description          :text
#  product_keywords     :text
#  product_type_id      :integer(4)      not null
#  prototype_id         :integer(4)
#  permalink            :string(255)     not null
#  available_at         :datetime
#  deleted_at           :datetime
#  meta_keywords        :string(255)
#  meta_description     :string(255)
#  featured             :boolean(1)      default(FALSE)
#  created_at           :datetime
#  updated_at           :datetime
#  description_markup   :text
#  active               :boolean(1)      default(FALSE)
#

class VariantRequiredError < StandardError; end

class Product < ActiveRecord::Base
  require_dependency 'product/pricing_manager'
  include Product::PricingManager

  extend FriendlyId
  friendly_id :permalink, use: :finders

  serialize :product_keywords, Array

  attr_accessor :available_shipping_rates # these the the shipping rates per the shipping address on the order

  scope :active, -> { where("products.deleted_at IS NULL OR products.deleted_at > ?", Time.zone.now) }
  
  scope :available_at_lt_filter, lambda do |available_at_lt| 
    where("products.available_at < ?", available_at_lt) if available_at_lt.present?
  end
  
  scope :available_at_gt_filter, lambda do |available_at_gt| 
    where("products.available_at > ?", available_at_gt) if available_at_gt.present?
  end
  
  scope :product_type_filter, lambda do |product_type_id| 
    where("products.product_type_id = ?", product_type_id) if product_type_id.present?
  end

  scope :name_filter, lambda do |name| 
    where("products.name LIKE ?", "#{name}%") if name.present?
  end
    
  belongs_to :product_type
  belongs_to :prototype
  belongs_to :shipping_rate
  belongs_to :shipping_method
  
  has_many :product_properties
  has_many :properties,         through: :product_properties

  has_many :variants
  has_many :images, -> {order(:position)}, as: :imageable, dependent: :destroy

  has_many :active_variants, -> { where(deleted_at: nil) }, class_name: 'Variant'

  before_validation :sanitize_data
  before_validation :not_active_on_create!, :on => :create
  before_save :create_content

  accepts_nested_attributes_for :variants,           reject_if: proc { |attributes| attributes['sku'].blank? }
  accepts_nested_attributes_for :product_properties, reject_if: proc { |attributes| attributes['description'].blank? }, allow_destroy: true
  accepts_nested_attributes_for :images,             reject_if: proc { |t| (t['photo'].nil? && t['photo_from_link'].blank?) }, allow_destroy: true

  validates :product_type_id,       presence: true
  validates :shipping_method_id,    presence: true
  validates :name,                  presence: true,   length: { :maximum => 165 }
  validates :description_markup,    presence: true,   length: { :maximum => 2255 },     :if => :active
  validates :meta_keywords,         presence: true,        length: { :maximum => 255 }, :if => :active
  validates :meta_description,      presence: true,        length: { :maximum => 255 }, :if => :active
  validates :permalink,             uniqueness: true,      length: { :maximum => 150 }

  def hero_variant
    active_variants.detect{|v| v.master } || active_variants.first
  end

  def featured_image(image_size = :small)
    Rails.cache.fetch("Product-featured_image-#{id}-#{image_size}", :expires_in => 3.hours) do
      images.first ? images.first.photo.url(image_size) : "no_image_#{image_size.to_s}.jpg"
    end
  end

  def image_urls(image_size = :small)
    Rails.cache.fetch("Product-image_urls-#{id}-#{image_size}", :expires_in => 3.hours) do
      images.empty? ? ["no_image_#{image_size.to_s}.jpg"] : images.map{|i| i.photo.url(image_size) }
    end
  end

  # in the admin form this is the method called when the form is submitted, The method sets
  # the product_keywords attribute to an array of these values
  #
  # @param [String] value for set_keywords in a products form
  # @return [none]
  def set_keywords=(value)
    self.product_keywords = value ? value.split(',').map{|w| w.strip} : []
  end

  # method used by forms to set the array of keywords separated by a comma
  #
  # @param [none]
  # @return [String] product_keywords separated by comma
  def set_keywords
    product_keywords ? product_keywords.join(', ') : ''
  end

  # Solr searching for products
  #
  # @param [args]
  # @param [params]  :rows, :page
  # @return [ Product ]
  def self.standard_search(args, params = {:page => 1, :per_page => 15})
      Product.includes( [:properties, :images]).active.
              where(['products.name LIKE ? OR products.meta_keywords LIKE ?', "%#{args}%", "%#{args}%"]).
              paginate(params)
  end

  # This returns the first featured product in the database,
  # if there isn't a featured product the first product will be returned
  #
  # @param [none]
  # @return [ Product ]
  def self.featured
    product = where({ :products => {:featured => true} } ).includes(:images).first
    product ? product : includes(:images).where(['products.deleted_at IS NULL']).first
  end

  def active(at = Time.zone.now)
    deleted_at.nil? || deleted_at >= at
  end
  def active?(at = Time.zone.now)
    active(at)
  end

  def activate!
    self.deleted_at = nil
    save
  end

  def available?
    active
  end

  # def brand_name
  #   brand_id ? brand.name : ''
  # end

  # paginated results from the admin products grid
  #
  # @param [Optional params]
  # @param [Optional Boolean] the state of the product you are searching (active == true)
  # @return [ Array[Product] ]
  def self.admin_grid(params = {}, active_state = nil)
    grid = includes(:variants).
                deleted_at_filter(active_state)#.
                # name_filter(params[:name]).
                # product_type_filter( params[:product_type_id] ).
                # available_at_gt_filter(params[:available_at_gt]).
                # available_at_lt_filter(params[:available_at_lt])
  end

  private

    def self.deleted_at_filter(active_state)
      if active_state
        active
      elsif active_state == false##  note nil != false
        where(['products.deleted_at IS NOT NULL AND products.deleted_at <= ?', Time.zone.now.to_s(:db)])
      else
        all
      end
    end

    def create_content
      self.description = BlueCloth.new(self.description_markup).to_html unless self.description_markup.blank?
    end

    def not_active_on_create!
      self.deleted_at = Time.zone.now
    end

    # if the permalink is not filled in set it equal to the name
    def sanitize_data
      sanitize_permalink
      assign_meta_keywords  if meta_keywords.blank? && description
      sanitize_meta_description
    end

    def sanitize_permalink
      self.permalink = name if permalink.blank? && name
      self.permalink = permalink.squeeze(" ").strip.gsub(' ', '-') if permalink
    end

    def sanitize_meta_description
      if name && description.present? && meta_description.blank?
        self.meta_description = [name.first(55), description.remove_hyper_text.first(197)].join(': ')
      end
    end

    def assign_meta_keywords
      self.meta_keywords =  [name.first(55),
                            description.
                            remove_non_alpha_numeric.           # remove non-alpha numeric
                            remove_hyper_text.                  # remove hyper text
                            remove_words_less_than_x_characters. # remove words less than 2 characters
                            first(197)                       # limit to 197 characters
                            ].join(': ')
    end
end