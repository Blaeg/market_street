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
  
  accepts_nested_attributes_for :cart_items

  # Call this method when you are checking out with the current cart items
  # => these will now be order.order_items
  # => the order can only add items if it is 'in_progress'
  #
  # @param [Order] order to insert the shopping cart variants into
  # @return [order]  return order because teh order returned has a diffent quantity
  def add_items_to_checkout(order)
    if order.in_progress?
      order.order_items.map(&:destroy)
      order.order_items.reload
      
      cart_items.each do |item|
        order.add_cart_item( item, nil)
      end      
    end
    order
  end

  # Call this method when you want to add an item to the shopping cart
  #
  # @param [Integer, #read] variant id to add to the cart
  # @param [Integer, #optional] ItemType id that is being added to the cart
  # @return [CartItem] return the cart item that is added to the cart
  def add_variant(variant_id, qty = 1)
    cart_item = cart_items.where(variant_id: variant_id).first
    quantity_to_purchase = Variant.find(variant_id).quantity_purchaseable_by_user(qty.to_i)
    return if quantity_to_purchase == 0
    if cart_item.nil? 
      cart_items.create(variant_id: variant_id, 
        quantity: quantity_to_purchase)
    else
      cart_item.update_attributes(:quantity => cart_item.quantity + quantity_to_purchase)
    end    
  end

  def remove_variant(variant_id)
    cart_items.where(variant_id: variant_id).map(&:inactivate!)
  end

  # Call this method when you want to associate the cart with a user
  #
  # @param [User]
  def save_user(u)  # u is user object or nil
    if u && self.user_id != u.id
      self.user_id = u.id
      self.save
    end
  end  
end