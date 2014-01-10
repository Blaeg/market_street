module OrderItem::Calculator
  def calculate_order
    set_beginning_values
    #order.calculate_totals
  end

  def adjusted_price(coupon = nil)
    ## coupon credit is calculated at the order level but because taxes we need to apply it now
    coupon_credit = coupon ? coupon.value([sale_price(order.completed_at)], order) : 0.0
    self.price - coupon_credit
  end

  # def sale_price(at)
  #   sale = sale_at(at)
  #   sale ? ( (1.0 - sale.percent_off) * self.price ).round_at(2) : self.price
  # end

  # def item_total(coupon = nil)
  #   self.total_amount ||= calculate_total(coupon)
  # end

  # def calculate_total(coupon = nil)
  #   self.total = (adjusted_price(coupon)).round_at(2)
  # end

  def tax_charge
    tax_percentage = tax_rate.try(:tax_percentage) ? tax_rate.tax_percentage : 0.0
    adjusted_price * tax_percentage / 100.0
  end

  def amount_of_charge_is_vat
    vat_percentage = tax_rate.try(:vat_percentage) ? tax_rate.vat_percentage : 0.0
    (adjusted_price * (vat_percentage / (100.0 + vat_percentage))).round_at(2)
  end

  def amount_of_charge_without_vat
    vat_percentage = tax_rate.try(:vat_percentage) ? tax_rate.vat_percentage : 0.0
    (100.0 * adjusted_price / (100.0 + vat_percentage)).round_at(2)
  end  
end
