require 'spec_helper'

describe ProductDecorator do
	let(:product) { create(:product) }
  
  before do 
    create(:variant, :product => product, :master => true, :price => 15.01)
    create(:variant, :product => product, :master => false, :price => 10.00)
  end

  subject { ProductDecorator.decorate(Product.find(product.id)) }

  it 'returns the lowest price' do
    subject.price.should == 10.00
  end

  it 'returns the price range' do
    subject.price_range.should == [10.0, 15.01]
  end

  it 'returns the price range' do
    subject.price_range?.should be_true
  end  
end