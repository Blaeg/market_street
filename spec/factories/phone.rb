FactoryGirl.define do
  factory :phone do
    phone_type { 'HOME' }
    phoneable_type 'User'
    phoneable_id  { FactoryGirl.create(:user).id }
    number '919-636-0383'
    primary true
  end
end
