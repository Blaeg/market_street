FactoryGirl.define do
  factory :transaction_ledger do
    accountable         { |c| c.association(:user) }
    transaction         { |c| c.association(:transaction) }
    transaction_account { |c| c.association(:transaction_account) }
    tax_amount          0.00
    debit               10.98
    credit              0.00
    period              '9-2010'
  end
end
