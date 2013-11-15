# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "referrals#{n}@example.com"
  end

  factory :referral do
    applied false
    clicked_at "2013-04-14 20:40:44"
    email { FactoryGirl.generate(:email) }
    name "John Doe"
    purchased_at "2013-04-14 20:40:44"

    referring_user      { |c| c.association(:user) }
    referral_program    { |c| c.association(:referral_program) }
    referral_user       { |c| c.association(:user) }
    referral_type_id         ReferralType::DIRECT_WEB_FORM_ID

    registered_at "2013-04-14 20:40:44"
    sent_at       "2013-04-14 20:40:44"
  end
end
