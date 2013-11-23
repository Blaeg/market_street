module Cart::Calculator
  def sub_total
    shopping_cart_items.map(&:total).sum
  end

  def number_of_shopping_cart_items
    shopping_cart_items.map(&:quantity).sum
  end
end
