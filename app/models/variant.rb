# Variant can be thought of as specific types of product.
#
# A product could be considered Levis 501 Blues
#   => Then a variant would specify the color and size of a specific pair of Jeans
#

# == Schema Information
#
# Table name: variants
#
#  id           :integer(4)      not null, primary key
#  product_id   :integer(4)      not null
#  sku          :string(255)     not null
#  name         :string(255)
#  price        :decimal(8, 2)   default(0.0), not null
#  cost         :decimal(8, 2)   default(0.0), not null
#  deleted_at   :datetime
#  master       :boolean(1)      default(FALSE), not null
#  created_at   :datetime
#  updated_at   :datetime
#  inventory_id :integer(4)
#

class Variant < ActiveRecord::Base
  require_dependency 'variant/pricing_manager'
  include Variant::PricingManager

  require_dependency 'variant/availability_manager'
  include Variant::AvailabilityManager

  has_many :variant_suppliers
  has_many :suppliers,         :through => :variant_suppliers

  has_many :variant_properties
  has_many :properties,          :through => :variant_properties

  has_many   :purchase_order_variants
  has_many   :purchase_orders, :through => :purchase_order_variants

  belongs_to :product
  belongs_to :inventory
  
  before_validation :create_inventory #, :on => :create
  #after_save :expire_cache

  validates :inventory_id, :presence => true
  validates :price, :presence => true
  validates :product_id, :presence => true
  validates :sku, :presence => true, :length => { :maximum => 255 }

  accepts_nested_attributes_for :variant_properties#, :inventory
  
  delegate  :count_on_hand,
            :count_pending_to_customer,
            :count_pending_from_supplier,
            :count_on_hand=,
            :count_pending_to_customer=,
            :count_pending_from_supplier=, :to => :inventory, :allow_nil => false

  def featured_image(image_size = :small)
    image_urls(image_size).first
  end

  def image_urls(image_size = :small)
    Rails.cache.fetch("variant-image_urls-#{self}-#{image_size}", :expires_in => 3.hours) do
      product.image_urls(image_size)
    end
  end

  # returns an array of the display name and description of all the variant properties
  #  ex: obj.sub_name => ['color: green', 'size: 9.0']
  #
  # @param [Optional String]
  # @return [Array]
  def property_details(separator = ': ')
    variant_properties.collect {|vp| [vp.property.display_name ,vp.description].join(separator) }
  end

  # returns a string the display name and description of all the variant properties
  #  ex: obj.sub_name => 'color: green <br/> size: 9.0']
  #
  # @param [Optional String] separator (default == <br/>)
  # @return [String]
  def display_property_details(separator = '<br/>')
    property_details.join(separator)
  end

  # returns the product name
  #  ex: obj.product_name => Nike
  #
  # @param [none]
  # @return [String]
  def product_name
    name? ? name : [product.name, sub_name].reject{ |a| a.strip.length == 0 }.join(' - ')
  end

  # returns the primary_property's description or a blank string
  #  ex: obj.sub_name => 'great shoes, blah blah blah'
  #
  # @param [none]
  # @return [String]
  def sub_name
    primary_property ? "#{primary_property.description}" : ''
  end

  # def brand_name
  #   product.brand_name
  # end

  # The variant has many properties.  but only one is the primary property
  #  this will return the primary property.  (good for primary info)
  #
  # @param [none]
  # @return [VariantProperty]
  def primary_property
    pp = self.variant_properties.where({ :variant_properties => {:primary => true}}).first
    pp ? pp : self.variant_properties.first
  end

  # returns the product name with sku
  #  ex: obj.name_with_sku => Nike: 1234-12345-1234
  #
  # @param [none]
  # @return [String]
  def name_with_sku
    [product_name, sku].compact.join(': ')
  end

  private
  
  def self.sku_filter(sku)
    if sku.present?
      where(['sku LIKE ? ', "#{sku}%"])
    else
      all
    end
  end
  
  def self.product_name_filter(product_name)
    if product_name.present?
      where({:products => {:name => product_name}})
    else
      all
    end
  end

  def create_inventory
    self.inventory = Inventory.create({:count_on_hand => 0, 
      :count_pending_to_customer => 0, 
      :count_pending_from_supplier => 0}) unless inventory_id
  end
end
