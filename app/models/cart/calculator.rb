module Cart::Calculator
  def subtotal_amount
    cart_items.map(&:subtotal_amount).sum
  end
  
  def shipping_amount
  	cart_items.map(&:shipping_amount).sum
  end
  
  def taxable_amount
    cart_items.map(&:taxable_amount).sum
  end
  
  def tax_amount
  	cart_items.map(&:tax_amount).sum
  end
  
  def total_amount
  	cart_items.map(&:total_amount).sum
  end

  def discount_amount
    0.0
  end

  def credit_amount
    0.0
  end  
end
