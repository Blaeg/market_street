class CheckoutService
  attr_accessor :cart, :order

  def initialize(cart)
    @cart = cart    
  end

  def new_order
    Cart.transaction do
      @order = ::Order.new(cart.to_order_attributes)
      @order.order_items = cart.cart_items.map do |cart_item|
         ::OrderItem.new(cart_item.to_order_item_attributes)
      end
    end
    @order
  end

  def checkout
    new_order.save!
  end  
end