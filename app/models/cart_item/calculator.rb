module CartItem::Calculator
  def subtotal_amount
    self.price * self.quantity
  end

  def shipping_amount
    10.0
  end

  def taxable_amount
    subtotal_amount + shipping_amount
  end

  def tax_amount
    taxable_amount * cart.tax_rate
  end

  def total_amount
    subtotal_amount + shipping_amount + tax_amount
  end  
end
