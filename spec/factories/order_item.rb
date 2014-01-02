FactoryGirl.define do
  factory :order_item do
    price         3.00
    total         3.15
    sequence(:quantity) { |i| i }
    order         { |c| c.association(:order) }
    variant       { |c| c.association(:variant) }
    tax_rate      { |c| c.association(:tax_rate) }
    sequence(:shipping_amount) { |i| (i%2) * 10 }
    shipment      { |c| c.association(:shipment) }
    after(:build) {|oi| oi.send(:initialize_state_machines, :dynamic => :force)}
  end
end
