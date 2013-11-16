FactoryGirl.define do
  factory :shipping_category do
    sequence(:name)      { |i| "Shipping Category #{i}" }
  end
end
