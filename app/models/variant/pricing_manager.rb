module Variant::PricingManager
  def total_price(tax_rate)
    ((1 + tax_percentage(tax_rate)) * price)
  end

  def tax_percentage(tax_rate)
    tax_rate ? tax_rate.tax_percentage : 0.0
  end

  def product_tax_rate(state_id, tax_time = Time.now)
    product.tax_rate(state_id, tax_time)
  end
end