FactoryGirl.define do
  factory :variant_property do
    variant       { |c| c.association(:variant) }
    property      { |c| c.association(:property) }
    sequence(:description) { |i| "Value #{i}"}        
  end
end
