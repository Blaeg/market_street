FactoryGirl.define do
  factory :property do
  	sequence(:identifing_name) { |i| "property_#{i}" }
  	sequence(:display_name) { |i| "Property #{i}" }    
  end
end
