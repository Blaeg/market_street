module Order::Calculator  
  def subtotal_amount
    cart_items.map(&:subtotal_amount).sum
  end

  def coupon_amount
  	coupon_id ? coupon.value(item_prices, self) : 0.0
  end

  # def credit_amount
  # 	(find_total - amount_to_credit).round_at( 2 )
  # end

  # def amount_to_credit
  # 	[find_total, user.store_credit.amount].min.to_f.round_at( 2 )
  # end

  # def all_order_items_have_a_shipping_rate?
  #   !order_items.any?{ |item| item.shipping_rate_id.nil? }
  # end

  #TAX
  def taxable_amount
    order_items.map(&:taxable_amount).sum.round_at( 2 )    
  end

  #SHIPPING
  def shipping_amount
    order_items.map(&:shipping_amount).sum    
  end

  private 

  def item_prices
    order_items.map(&:price)
  end
end
