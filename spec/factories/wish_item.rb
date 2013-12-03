# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :wish_item, :class => 'WishItem' do
    user { |c| c.association(:user) }
    variant { |c| c.association(:variant) }
  end
end
