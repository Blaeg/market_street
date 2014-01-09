FactoryGirl.define do
  factory :shipment do
    order_item      { |c| c.association(:order_item) }
    address         { |c| c.association(:address) }
    state           "ready_to_ship"
    shipped_at      nil
    active          true

    after(:build) {|oi| oi.send(:initialize_state_machines, :dynamic => :force)}
  end
end
