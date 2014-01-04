FactoryGirl.define do
  factory :variant do
    sku                 '345-98765-0987'
    product             { |c| c.association(:product) }
    sequence(:price)    { |i| 11.1*i }
    sequence(:retail)   { |i| 16.1*i }
    sequence(:cost)     { |i| 5.1*i }
    deleted_at          nil
    master              false
    inventory           { |c| c.association(:inventory) }    
    name { Forgery(:lorem_ipsum).words( rand( 3..8 ), :random => true).titlecase }

    trait(:with_properties) do
      after(:create) do |v|
        3.times do 
          v.variant_properties.push(create(:variant_property, :variant => v))
        end
      end
    end

    factory :five_dollar_variant, :class => Variant do |f| # :parent => :variant,
      price  5.00
    end

    factory :ten_dollar_variant, :class => Variant do |f| # :parent => :variant,
      price  10.00      
    end
  end
end
