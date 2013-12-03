FactoryGirl.define do

  factory :cart_item do |ci|
    variant       { |c| c.association(:variant) }
    cart          { |c| c.association(:cart) }
    quantity      1
    active        true
  end

  factory :five_dollar_cart_item, :parent => :cart_item do |ci|
    variant       { |c| c.association(:five_dollar_variant) }
    active        true
  end
end
