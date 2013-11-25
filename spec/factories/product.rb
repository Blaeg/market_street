FactoryGirl.define do
  factory :product do
    name { Forgery(:lorem_ipsum).words( rand( 3..8 ), :random => true).titlecase }
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
        p.product_properties.push(create(:product_property, :product => p))
      end
    end

    trait(:with_images) do
      after(:create) do |p|
        4.times do 
          p.images.push(create(:image, :imageable => p))
        end
      end
    end    
  end

  factory :product_with_image, :parent => :product do
    valid_file = File.new(File.join(Rails.root, 'spec', 'support', 'rails.png'))
    images {
      [
        ActionController::TestUploadedFile.new(valid_file, Mime::Type.new('application/png'))
      ]
    }
  end
end
