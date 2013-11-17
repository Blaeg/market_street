FactoryGirl.define do
  factory :shipping_method do
    sequence(:name) { |i| "shipping method #{i}" }
  end
end
