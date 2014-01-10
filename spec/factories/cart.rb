FactoryGirl.define do
  factory :cart do
    user { |c| c.association(:user) }
  end

  factory :cart_with_items, :parent => :cart do
    cart_items  { |items| [ items.association(:five_dollar_cart_item),
                            items.association(:ten_dollar_cart_item) ]}
  end

  factory :cart_ready_to_checkout, :parent => :cart_with_items do
		    
  end
end