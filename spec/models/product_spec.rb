require 'spec_helper'

describe Product, ".instance methods with images" do
  before(:each) do
    @product = create(:product_with_image)
  end

  context "featured_image" do
    xit 'returns an image url' do
      @your_model.should_receive(:save_attached_files).and_return(true)
      Image.new :photo => File.new(Rails.root + 'spec/fixtures/images/rails.png')
     @product.featured_image.should_not be_nil
    end
  end
end

describe Product, ".instance methods" do
  before(:each) do
    product  = create(:product)
    @previous_master = create(:variant, :product => product, :master => true, :price => 15.05, :deleted_at => (Time.zone.now - 1.day ))
    create(:variant, :product => product, :master => true, :price => 15.01)
    create(:variant, :product => product, :master => false, :price => 10.00)
    @product  = Product.find(product.id)
  end

  context "featured_image" do

    it 'returns no_image url' do
      @product.featured_image.should        == 'no_image_small.jpg'
      @product.featured_image(:mini).should == 'no_image_mini.jpg'
    end

  end

  context ".set_keywords=(value)" do
    it 'set keywords' do
      @product.set_keywords             =  'hi, my, name, is, Dave'
      @product.product_keywords.should  == ['hi', 'my', 'name', 'is', 'Dave']
      @product.set_keywords.should      == 'hi, my, name, is, Dave'
    end
  end  
end


describe Product, "class methods" do

  context "#standard_search(args)" do
    it "search products" do
      product1  = create(:product, :meta_keywords => 'no blah', :name => 'blah')
      product2  = create(:product, :meta_keywords => 'tester blah')
      product1.activate!
      product2.activate!
      args = 'tester'
      products = Product.standard_search(args)
      products.include?(product1).should be_false
      products.include?(product2).should be_true
    end
  end

  context "#featured" do
    pending "test for featured"
  end  
end
