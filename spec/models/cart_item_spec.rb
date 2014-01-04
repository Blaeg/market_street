require 'spec_helper'

describe CartItem do
  context "CartItem" do
    let(:cart_item) { build(:cart_item) }
    it "is valid with minimum attributes" do
      expect(cart_item).to be_valid
    end

    it 'is created active' do
      expect(cart_item.active).to be_true      
    end

    it 'is not active' do
      cart_item.inactivate!
      expect(cart_item).not_to be_active
    end
    
    it 'is not active after inactivation' do
      cart_item.inactivate!
      expect(cart_item.active).to be_false      
    end
  end

  context "calculator" do
    let(:cart_item) { create(:five_dollar_cart_item, :quantity => 2) }
    it 'has a price of the variant which is 5 dollars' do
      expect(cart_item.price.to_f).to eq 5.0
    end

    it 'has a subtotal_amount' do
      expect(cart_item.subtotal_amount.to_f).to eq 10.0
    end
    
    it 'has a taxable_amount' do
      expect(cart_item.taxable_amount.to_f).to eq 20.0
    end

    it 'has a tax_amount' do
      expect(cart_item.tax_amount.to_f).to eq 2
    end

    it 'has a total amount' do
    expect(cart_item.total_amount.to_f).to eq 22
    end
  end  
end