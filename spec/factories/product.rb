FactoryGirl.define do
  factory :product do
    name { Forgery(:lorem_ipsum).words( rand( 3..10 ), :random => true).titlecase }
    description { Forgery(:lorem_ipsum).sentences(4, :random => true) }
    description_markup   { Forgery(:lorem_ipsum).sentences(4, :random => true) }
    product_type         { |c| c.association(:product_type) }
    prototype            { |c| c.association(:prototype) }
    shipping_method      { |c| c.association(:shipping_method) }  
    available_at         Time.now
    featured             true
    sequence(:permalink) { |i| "permalink  #{i}" }    
    meta_description     'Describe the variant'
    meta_keywords        'Key One, Key Two'

    trait(:with_properties) do
      after(:create) do |p|
        3.times do 
          p.product_properties << create(:product_property)
        end
      end
    end

    trait(:with_variants) do
      after(:create) do |p|
        2.times do
          p.variants << create(:variant)
        end
      end
    end

    trait(:with_images) do
      after(:create) do |p|
        2.times do 
          p.images << create(:image, :imageable => p)
        end
      end
    end    
  end
end
