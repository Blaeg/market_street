FactoryGirl.define do
  factory :cart_item do |ci|
    variant       { |c| c.association(:variant) }
    cart          { |c| c.association(:cart) }
    quantity      1
    is_active     true
  
    factory :five_dollar_cart_item, :parent => :cart_item do |ci|
      variant       { |c| c.association(:five_dollar_variant) }      
    end

    factory :ten_dollar_cart_item, :parent => :cart_item do |ci|
      variant       { |c| c.association(:ten_dollar_variant) }      
    end
  end
end
