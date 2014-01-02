FactoryGirl.define do
  factory :shipment do
    order           { |c| c.association(:order) }
    address         { |c| c.association(:address) }
    state           "ready_to_ship"
    shipped_at      nil
    active          true

    after(:build) {|oi| oi.send(:initialize_state_machines, :dynamic => :force)}
  end
end
