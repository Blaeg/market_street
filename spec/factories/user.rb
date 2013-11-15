FactoryGirl.define do
  factory :user do
    first_name  'John'
    last_name   'Doe'
    sequence(:email)      { |n| "person#{n}@foundryfair.com" }
    password              'pasword'
    password_confirmation "pasword"
    after(:build) {|user| user.send(:initialize_state_machines, :dynamic => :force)}

    trait :with_address do
      after(:create) do |instance|
        instance.addresses = [create(:address, :addressable => instance)]
        instance.save!
      end
    end
  end

  factory :admin_user, :parent => :user do
    before(:create) do |u|
      u.roles = [Role.find_by_name(Role::ADMIN)]
    end
  end

  factory :super_admin_user, :parent => :user do
    before(:create) do |u|
      u.roles = [Role.find_by_name(Role::SUPER_ADMIN)]
    end
  end
end
