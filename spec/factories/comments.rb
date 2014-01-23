FactoryGirl.define do
  factory :comment do
    note { Forgery(:lorem_ipsum).sentences(3, random: true) }
    commentable { |c| c.association(:product) }
    created_by  { |c| c.association(:user).id }
    user        { |c| c.association(:user) }
  end
end