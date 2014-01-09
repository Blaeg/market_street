FactoryGirl.define do
  factory :order_item do
    sequence(:price) { |i| (i%2+1) * 100 }
    sequence(:quantity) { |i| i }    
    order         { |c| c.association(:order) }
    variant       { |c| c.association(:variant) }
    sequence(:tax_amount) { |i| (i%2+1) * 10 }
    sequence(:shipping_amount) { |i| (i%2+1) * 10 }
    sequence(:total_amount) { |i| (i%2+1) *  120 } 
    after(:build) {|oi| oi.send(:initialize_state_machines, :dynamic => :force)}
  end
end
