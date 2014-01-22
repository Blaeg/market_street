require 'spec_helper'

describe ProductDecorator do
	let(:product) { create(:product) }
  
  before do 
    create(:variant, product: product, master: true, price: 15.01)
    create(:variant, product: product, price: 10.00)
  end

  subject { ProductDecorator.decorate(Product.find(product.id)) }

  it 'returns the lowest price' do
    expect(subject.price).to eq 10.00
  end

  it 'returns the price range' do
    expect(subject.price_range).to eq [10.0, 15.01]
  end

  it "displays price label" do 
    expect(subject.price_label).to eq "$10.00-$15.01"    
  end

  it "displays short name" do 
    expect(subject.short_name.length).to be <= ProductDecorator::SHORT_LENGTH
  end
end