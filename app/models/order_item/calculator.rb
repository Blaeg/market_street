module OrderItem::Calculator
	def subtotal_amount
    self.price * self.quantity
  end
  
  def calculate_order
    set_beginning_values    
  end

  def adjusted_price(coupon = nil)
    coupon_credit = coupon ? coupon.value([sale_price(order.completed_at)], order) : 0.0
    self.price - coupon_credit
  end    
end
