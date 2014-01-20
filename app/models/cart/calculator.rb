module Cart::Calculator
  def total_quantity 
    cart_items.map(&:quantity).sum
  end
  
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

  #todo lookup in real time
  def tax_rate
    0.10
  end
end
