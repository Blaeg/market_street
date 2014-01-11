FactoryGirl.define do
  factory :cart do
    user { |c| c.association(:user) }
    is_active true
  end

  factory :cart_with_items, :parent => :cart do
    cart_items  { |items| [ items.association(:five_dollar_cart_item),
                            items.association(:ten_dollar_cart_item) ]}
  end

  factory :cart_ready_to_checkout, :parent => :cart_with_items do
		bill_address { |c| c.association(:bill_address) }
    ship_address { |c| c.association(:ship_address) }
  end
end