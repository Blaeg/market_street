FactoryGirl.define do
  factory :prototype do
    sequence(:name) { |i| "prototype #{i}" }
  end
end
