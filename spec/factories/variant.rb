FactoryGirl.define do
  factory :variant do
    sku           '345-98765-0987'
    product       { |c| c.association(:product) }
    brand         { |c| c.association(:brand) }
    sequence(:price) { |i| 11.1*i }
    cost          8.00
    deleted_at    nil
    master        false
    inventory     { |c| c.association(:inventory) }    
  end


  factory :five_dollar_variant, :class => Variant do |f| # :parent => :variant,
    price  5.00
    sku           '345-98765-0980'
    product       { |c| c.association(:product) }
    brand       { |c| c.association(:brand) }
    cost          3.00
    deleted_at    nil
    master        false
    inventory     { |c| c.association(:inventory) }
  end
end
