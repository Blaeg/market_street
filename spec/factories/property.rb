FactoryGirl.define do
  factory :property do
  	sequence(:identifing_name) { |i| 'identifing_name #{i}'}
  	sequence(:display_name) { |i| 'display_name #{i}'}    
  end
end
