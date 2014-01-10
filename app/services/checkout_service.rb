class CheckoutService
  attr_accessor :cart, :order

  def initialize(cart)
    @cart = cart    
  end

  def build_new_order
    @order = ::Order.new(cart.to_order_attributes)
    cart.cart_items.each do |cart_item|
      @order.order_items.build(cart_item.to_order_item_attributes)
    end
    @order
  end

  def checkout
    return unless cart.ready_to_checkout? 
    new_order = build_new_order
    new_order.save!
    new_order
  end    
end