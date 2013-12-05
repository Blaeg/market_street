FactoryGirl.define do
  factory :address do
    sequence(:first_name) { |n| Forgery::Name.first_name }
    sequence(:last_name)  { |n| Forgery::Name.last_name }
    address1 { Faker::Address.street_address() }
    address2 { Faker::Address.secondary_address() }
    city       'Fredville'
    state     { State.first }
    zip_code  '54322'
    address_type 'SHIPPING'
    addressable  { |c| c.association(:user) }
  end
end