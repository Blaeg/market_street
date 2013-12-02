FactoryGirl.define do
  factory :transaction do
    type      'Transactions::CreditCardPurchase'
    batch     { |c| c.association(:batch) }
  end
end
