module OrderItem::Calculator
	def subtotal_amount
    self.price * self.quantity
  end  
end
