module Order::Calculator
  # calculates the total price of the order
  # this method will set sub_total and total for the order even if the order is not ready for final checkout
  #
  # @param [none] the param is not used right now
  # @return [none]  Sets sub_total and total for the object
  def find_total(force = false)
  	calculate_totals if self.calculated_at.nil? || order_items.any? {|item| (item.updated_at > self.calculated_at) }
  	self.deal_time ||= Time.zone.now
  	self.deal_amount = Deal.best_qualifing_deal(self)
  	self.find_sub_total
  	taxable_money     = (self.sub_total - deal_amount - coupon_amount) * ((100.0 + order_tax_percentage) / 100.0)
  	self.total        = (self.sub_total + shipping_charges - deal_amount - coupon_amount ).round_at( 2 )
  	self.taxed_total  = (taxable_money + shipping_charges).round_at( 2 )
  end

  def find_sub_total
  	self.total = 0.0
  	order_items.each do |item|
  		self.total = self.total + item.item_total
  	end
  	self.sub_total = self.total
  end

  def taxed_amount
  	(get_taxed_total - total).round_at( 2 )
  end

  def get_taxed_total
  	taxed_total || find_total
  end

  # Turns out in order to determine the order.total_price correctly (to include coupons and deals and all the items)
  #     it is much easier to multiply the tax times to whole order's price.  This should work for most use cases.  It
  #     is rare that an order going to one location would ever need 2 tax rates
  #
  # For now this method will just look at the first item's tax rate.  In the future tax_rate_id will move to the order object
  #
  # @param none
  # @return [Float] tax rate  10.5% === 10.5
  def order_tax_percentage
  	(!order_items.blank? && order_items.first.tax_rate.try(:percentage)) ? order_items.first.tax_rate.try(:percentage) : 0.0
  end

  # amount the coupon reduces the value of the order
  #
  # @param [none]
  # @return [Float] amount the coupon reduces the value of the order
  def coupon_amount
  	coupon_id ? coupon.value(item_prices, self) : 0.0
  end

  # called when creating the invoice.  This does not change the store_credit amount
  #
  # @param [none]
  # @return [Float] amount that the order is charged after store credit is applyed
  def credited_total
  	(find_total - amount_to_credit).round_at( 2 )
  end

  # amount to credit based off the user store credit
  #
  # @param [none]
  # @return [Float] amount to remove from store credit
  def amount_to_credit
  	[find_total, user.store_credit.amount].min.to_f.round_at( 2 )
  end

  # all the tax charges to apply to the order
  #
  # @param [none]
  # @return [Array] array of tax charges that will be charged
  def tax_charges
  	order_items.map {|item| item.tax_charge }
  end

  # sum of all the tax charges to apply to the order
  #
  # @param [none]
  # @return [Decimal]
  def total_tax_charges
  	tax_charges.sum
  end
end
