# == Schema Information
#
# Table name: order_items
#
#  id               :integer(4)      not null, primary key
#  price            :decimal(8, 2)
#  total            :decimal(8, 2)
#  order_id         :integer(4)      not null
#  variant_id       :integer(4)      not null
#  state            :string(255)     not null
#  shipping_amount  :float
#  shipment_id      :integer(4)
#  created_at       :datetime
#  updated_at       :datetime
#

class OrderItem < ActiveRecord::Base
  require_dependency 'order_item/calculator'
  include OrderItem::Calculator

  require_dependency 'order_item/states'
  include OrderItem::States

  belongs_to :order
  belongs_to :shipping_rate
  belongs_to :variant
  belongs_to :tax_rate
  belongs_to :shipment

  has_many   :shipments
  has_many   :return_items

  #after_save :calculate_order
  after_find :set_beginning_values
  after_destroy :set_order_calculated_at_to_nil

  validates :variant_id,  :presence => true
  #validates :order_id,    :presence => true
  validates :quantity,    :presence => true

  def set_beginning_values
    @beginning_total            = self.total            rescue @beginning_total = nil # this stores the initial value of the total
  end

  def product_type
    variant.product.product_type
  end

  def product_type_ids
    product_type.self_and_ancestors.map(&:id)
  end

  def sale_at(at = Time.zone.now)
    Sale.for(variant.product_id, at)
  end  
end