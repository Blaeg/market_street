module CartItem::Calculator
  
  # Call this if you need to know the unit price of an item
  #
  # @param [none]
  # @return [Float] price of the variant in the cart
  def price
    self.variant.price
  end

  def total
    self.price * self.quantity
  end

  def shipping_amount
    10.0
  end
end
