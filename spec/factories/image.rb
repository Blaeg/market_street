FactoryGirl.define do
  factory :image do
    #batchable_type  'Order'
    sequence(:photo) { |i| File.new("#{Rails.root}/spec/fixtures/images/products/p#{i%9+1}.png") } 
    imageable        { |c| c.association(:product) }
    caption          'Caption blah.'
    position         1
  end
end
