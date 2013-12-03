module Cart::Calculator
  def sub_total
    cart_items.map(&:total).sum
  end

  def number_of_cart_items
    cart_items.map(&:quantity).sum
  end
end
