# To understand this model more please look at the documentation in the CART.rb model

# == Schema Information
#
# Table name: cart_items
#
#  id           :integer(4)      not null, primary key
#  user_id      :integer(4)
#  cart_id      :integer(4)
#  variant_id   :integer(4)      not null
#  quantity     :integer(4)      default(1)
#  active       :boolean(1)      default(TRUE)
#  created_at   :datetime
#  updated_at   :datetime
#

class CartItem < ActiveRecord::Base
  require_dependency 'cart_item/calculator'
  include CartItem::Calculator

  belongs_to :user
  belongs_to :cart
  belongs_to :variant

  validates :variant_id,    :presence => true

  before_save :inactivate_zero_quantity

  scope :before, -> (at) { where( "cart_items.created_at <= ?", at ) }
  scope :between, -> (start_time, end_time) { where("orders.completed_at >= ? AND orders.completed_at <= ?", start_time, end_time) }

  delegate :price, :to => :variant

  def name
    variant.product_name
  end

  # Call this method to soft delete an item in the cart
  #
  # @param [none]
  # @return [Boolean]
  def inactivate!
    self.update_attributes(:active => false)
  end

  def active?
    self.active
  end

   def to_order_item_attributes
    {
      :variant           => variant,
      :price             => price,
      :quantity          => quantity,
      :shipping_amount   => shipping_amount,
      :tax_amount        => tax_amount
    }
  end

  private

  def inactivate_zero_quantity
    active = false if quantity == 0
  end
end