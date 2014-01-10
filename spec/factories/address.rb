FactoryGirl.define do
  factory :address do
    sequence(:first_name) { |n| Forgery::Name.first_name }
    sequence(:last_name)  { |n| Forgery::Name.last_name }
    address1 { Faker::Address.street_address() }
    address2 { Faker::Address.secondary_address() }
    city       'San Francisco'
    state     { State.first }
    zip_code  '54322'
    addressable  { |c| c.association(:user) }
  end

  factory :bill_address, :parent => :address do
    address_type 'BILLING'    
  end

  factory :ship_address, :parent => :address do
    address_type 'SHIPPING'    
  end
end