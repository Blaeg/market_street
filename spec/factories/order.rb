FactoryGirl.define do
  factory :order do
    email           'email@e.com'
    state           'initial'
    user            { |c| c.association(:user) }
    bill_address    { |c| c.association(:address) }
    ship_address    { |c| c.association(:address) }
    completed_at    Time.now

    after(:build) {|oi| oi.send(:initialize_state_machines, :dynamic => :force)}
  end

  factory :completed_order, :parent => :order do
    state 'completed'
  end
end
