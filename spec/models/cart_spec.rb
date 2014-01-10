require 'spec_helper'

describe Cart, ".sub_total" do
  context "calculator" do
    let(:cart) { create(:cart_with_items) }
    
    it 'has a subtotal_amount' do
      expect(cart.subtotal_amount.to_f).to eq 15.0
    end
    
    it 'has a taxable_amount' do
      expect(cart.taxable_amount.to_f).to eq 35.0
    end

    it 'has a tax_amount' do
      expect(cart.tax_amount.to_f).to eq 3.5
    end

    it 'has a total amount' do
      expect(cart.total_amount.to_f).to eq 38.5
    end
  end  
end

describe Cart, ".save_user(u)" do
  let(:cart) { create(:cart_with_items) }  
  let(:user) { create(:user) }

  it 'assign the user to the cart' do      
    cart.save_user(user)
    expect(cart.user).to eq user      
  end
end

describe Cart, "add_variant" do
  let(:cart) { create(:cart_with_items) }
  let(:variant) { create(:variant) }
  
  it 'adds variant to cart' do
    Variant.any_instance.stubs(:quantity_available).returns(10)
    expect{cart.add_variant(variant.id)}.to change{
      cart.cart_items.size
    }.by(1)
  end

  it 'adds quantity of variant to cart' do
    Variant.any_instance.stubs(:quantity_available).returns(10)
    cart_item_size = cart.cart_items.size
    
    cart.add_variant(variant.id)
    cart.add_variant(variant.id)

    cart.reload.cart_items.each do |item|
      expect(item.quantity).to eq 2 if item.variant_id == variant.id
    end
    expect(cart.cart_items.size).to eq(cart_item_size + 1)    
  end

  it 'adds quantity of variant if out of stock' do
    Variant.any_instance.stubs(:quantity_available).returns(0)
    expect{cart.add_variant(variant.id)}.to change {
      cart.reload.cart_items.size
    }.by(0)
  end
end

describe Cart, ".remove_variant" do
  let(:cart) {create(:cart_with_items)}
  it 'inactivate variant in cart' do
    variant_id = cart.cart_items.first.variant_id
    cart.remove_variant(variant_id)
    expect(cart.cart_items.first).to be_active
  end
end

describe Cart, "#ready_to_checkout?" do 
  context "with items but no addresses" do 
    let(:cart) { create(:cart_with_items) }
    it "is not ready to checkout" do 
      expect(cart).not_to be_ready_to_checkout
    end
  end
  context "with items and addresses" do 
    let(:cart) { create(:cart_ready_to_checkout) }
    it "is ready to checkout" do 
      expect(cart).to be_ready_to_checkout
    end
  end
end