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
  belongs_to :user
  belongs_to :cart
  belongs_to :variant

  validates :variant_id,    :presence => true

  before_save :inactivate_zero_quantity

  # Call this if you need to know the unit price of an item
  #
  # @param [none]
  # @return [Float] price of the variant in the cart
  def price
    self.variant.price
  end

  def name
    variant.product_name
  end

  # Call this method if you need the price of an item before taxes
  #
  # @param [none]
  # @return [Float] price of the variant in the cart times quantity
  def total
    self.price * self.quantity
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

  def shipping_rate
    variant.product.shipping_rate
  end

  def self.before(at)
    where( "cart_items.created_at <= ?", at )
  end

  private

  def inactivate_zero_quantity
    active = false if quantity == 0
  end
end