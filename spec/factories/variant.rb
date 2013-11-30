FactoryGirl.define do
  factory :variant do
    sku                 '345-98765-0987'
    product             { |c| c.association(:product) }
    sequence(:price)    { |i| 11.1*i }
    sequence(:retail)   { |i| 16.1*i }
    cost                8.00
    deleted_at          nil
    master              false
    inventory           { |c| c.association(:inventory) }    

    trait(:with_properties) do
      after(:create) do |v|
        3.times do 
          v.variant_properties.push(create(:variant_property, :variant => v))
        end
      end
    end
  end

  factory :five_dollar_variant, :class => Variant do |f| # :parent => :variant,
    price  5.00
    sku           '345-98765-0980'
    product       { |c| c.association(:product) }
    cost          3.00
    deleted_at    nil
    master        false
    inventory     { |c| c.association(:inventory) }
    #count_on_hand             10000
    #count_pending_to_customer 1000
    #count_pending_from_supplier 900
  end
end
