# the cart is simply a bucket of stuff.  it is very well documented in a blog post I have posted:

# The first thing that comes to mind of a great cart is that it is "stupid".
# Sure that might sound crazy but it is very true. A shopping cart should not know much
# about your "order" or your "products". Your cart should simply be a bucket to keep a
# bunch of products for a specific user. It doesn't know the price of the products or
# anything about the checkout process.
#
# The second thing about a great cart is that it ironically it is "smart" about itself.
# Your cart should NOT know about the order or products but it should know about itself.
# Note your cart is the combination of a "cart model" and "cart_items model". This cart_items
# model has the following fields:
#
# cart_id
# product_id
# quantity
# Additionally the cart should only have the following field:
#
# user_id
#
# What this simple field in the DB does is allows you to have a wish list and save for later
# functionality out of the box. Additionally you can WOW your marketing team by telling them
# all the items a user has ever deleted out of their cart or purchased. If you ever need to create
# a recommendation engine your cart will give you all the data you need.
#
# _______________________


# == Combining the Cart and Order Objects
#
# I've heard the argument that using an order object for the cart "make things easier".
# Not only do I disagree but sorry, "You would be wrong". By mixing the cart and the order you have not
# separated concerns. This can make validations very conditional. It also mixes cart logic with order logic.
#
# I view your cart as something that can be removed off the face of the planet and not effect much. Sure
# people would be upset to add things back to their cart but at the end of the day it would not effect anything
# financially. The order however is sacred. If an order was deleted you could lose financial data and even
# fulfillment information. Hence you don't want to be messing around with the order because you could be
# shooting yourself in the foot.
#
# By nature your cart has a lot of abandoned records. If the order and cart are separated you could very easily
# archive the carts without much worry. If your order is your cart the risk to do this would be too great.
# One small bug could cost you way too much.
#
# Now you have an extremely slim cart with a tremendous amount of functionality.

# == Removing an item
#
# The when the item is removed from the cart instead of deleting the cart_item the item is
# changed to active = false.  This allows you to see the state of the item when it was removed from the cart.
#
# Take a look at [This Blog Post](http://www.ror-e.com/posts/29-e-commerce-tips-1-2-the-shopping-cart) for more details.


# == Schema Information
#
# Table name: carts
#
#  id          :integer(4)      not null, primary key
#  user_id     :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#  customer_id :integer(4)
#

class Cart < ActiveRecord::Base
  require_dependency 'cart/calculator'
  include Cart::Calculator

  belongs_to  :user
  has_many    :cart_items

  belongs_to :ship_address, class_name: 'Address'
  belongs_to :bill_address, class_name: 'Address'

  accepts_nested_attributes_for :cart_items, :ship_address, :bill_address

  def add_variant(variant_id, quantity = 1)
    cart_item = cart_items.where(variant_id: variant_id).first
    purchaseable_quantity = Variant.find(variant_id).purchaseable_quantity(quantity.to_i)
    return if purchaseable_quantity == 0
    if cart_item.nil?
      cart_items.create(variant_id: variant_id, 
                        quantity: purchaseable_quantity)
    else
      new_quantity = cart_item.quantity + purchaseable_quantity
      cart_item.update_attributes(:quantity => new_quantity)
    end    
  end

  def remove_variant(variant_id)
    cart_items.where(variant_id: variant_id).map(&:inactivate!)
  end

  def save_user(user)  # u is user object or nil
    self.user = user
    self.save
  end  

  def ready_to_checkout?
    user.present? and !cart_items.empty? and 
    ship_address.present? and bill_address.present?
  end

  def to_order_attributes
    {
      :user      => user,
      :email => user.email,
      :cart_id   => id,

      :tax_rate => tax_rate,
      :tax_amount => tax_amount,
      :credit_amount => credit_amount,
      :shipping_amount => shipping_amount,  
      :total_amount => total_amount,
      
      :ship_address_id => ship_address_id,
      :bill_address_id => bill_address_id,      
    }
  end    
end