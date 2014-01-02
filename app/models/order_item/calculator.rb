module OrderItem::Calculator
  def calculate_order
    if self.ready_to_calculate? && (tax_rate_id != @beginning_tax_rate_id)
      set_beginning_values
      order.calculate_totals
    end
  end

  # if something changes to the order item and you dont want to recalculate
  #   (maybe because you are chnging several more things) then
  #    this method will mark the calculated at to be nil and thus tell the order that
  #    it needs to calculate the total again
  #
  # @param [none]
  # @return [none]
  def set_order_calculated_at_to_nil
    order.update_attribute(:calculated_at, nil)
  end

  def ready_to_calculate?
    tax_rate_id
  end

  # this is the price after coupons and anything before calculating the price + tax
  #  in the future coupons and discounts could change this value
  #
  # @param [none]
  # @return [Float] this is the price that the tax will be applied to.
  def adjusted_price(coupon = nil)
    ## coupon credit is calculated at the order level but because taxes we need to apply it now
    coupon_credit = coupon ? coupon.value([sale_price(order.transaction_time)], order) : 0.0
    self.price - coupon_credit
  end

  def sale_price(at)
    sale = sale_at(at)
    sale ? ( (1.0 - sale.percent_off) * self.price ).round_at(2) : self.price
  end

  # this is the price after coupons and taxes
  #   * this return total if has not been calculated, otherwise calculates the total.
  #
  # @param [none]
  # @return [Float] this is the total of the item after taxes and coupons...
  def item_total(coupon = nil)
    # shipping charges are calculated in order.rb

    self.total ||= calculate_total(coupon)
  end

  # this is the price after coupons, deals and sales
  #   * this method does not save it just sets the value of total.
  #   * Thus allowing you to save the whole order with one opperation
  #
  # @param [none]
  # @return [Float] this is the total of the item after coupons/deals/sales...
  def calculate_total(coupon = nil)
    # shipping charges are calculated in order.rb

    self.total = (adjusted_price(coupon)).round_at(2)
  end

  # the tax charge on an item
  #
  # @param [none]
  # @return [Float] tax charge on the item.
  def tax_charge
    tax_percentage = tax_rate.try(:tax_percentage) ? tax_rate.tax_percentage : 0.0
    adjusted_price * tax_percentage / 100.0
  end

  # the VAT charge on an item
  #
  # @param [none]
  # @return [Float] tax charge on the item.
  def amount_of_charge_is_vat
    vat_percentage = tax_rate.try(:vat_percentage) ? tax_rate.vat_percentage : 0.0
    (adjusted_price * (vat_percentage / (100.0 + vat_percentage))).round_at(2)
  end

  # the amount of an item if there were zero VAT
  #
  # @param [none]
  # @return [Float] tax charge on the item.
  def amount_of_charge_without_vat
    vat_percentage = tax_rate.try(:vat_percentage) ? tax_rate.vat_percentage : 0.0
    (100.0 * adjusted_price / (100.0 + vat_percentage)).round_at(2)
  end  
end
