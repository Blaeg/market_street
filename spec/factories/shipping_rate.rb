FactoryGirl.define do
  factory :shipping_rate do
    rate                  21.08
    shipping_method       { |c| c.association(:shipping_method) }
    shipping_rate_type    { ShippingRateType.first }
    minimum_charge        2.95
    position              1
    active                true
  end
end
