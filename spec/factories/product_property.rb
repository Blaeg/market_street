FactoryGirl.define do
  factory :product_property do
    product         { |c| c.association(:product) }
    property        { |c| c.association(:property) }
    sequence(:description) { |i| "Value #{i}"}        
  end
end
