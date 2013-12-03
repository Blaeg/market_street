require 'spec_helper'

describe Cart, ".sub_total" do
  # cart_items.inject(0) {|sum, item| item.total + sum}
  
  before(:each) do
    @cart = create(:cart_with_two_5_dollar_items)
  end
  
  it "calculates subtotal correctly" do
    @cart.sub_total.should == 10.00
  end

  it "gives the number of cart items" do
    @cart.number_of_cart_items.should == 2
  end

  it "gives the number of cart items" do
    variant = FactoryGirl.create(:variant)
    @cart.add_variant(variant.id, 2)
    @cart.number_of_cart_items.should == 4
  end
end

describe Cart, " instance methods" do
  before(:each) do
    @cart = create(:cart_with_two_5_dollar_items)
  end

  context " add_items_to_checkout" do    
    before(:each) do
      @order = create(:in_progress_order)
    end
    
    it 'should add item to in_progress orders' do
      @cart.add_items_to_checkout(@order)
      @order.order_items.size.should == 2      
    end
    
    it 'should keep items already in order to in_progress orders' do
      @cart.add_items_to_checkout(@order)
      @cart.add_items_to_checkout(@order)
      @order.order_items.size.should == 2
    end
    
    it 'should add only needed items already in order to in_progress orders' do
      @cart.add_items_to_checkout(@order)
      @cart.cart_items.push(create(:cart_item))
      @cart.add_items_to_checkout(@order)
      @order.order_items.size.should == 3     
    end
    
    it 'should remove items not in cart to in_progress orders' do
      @cart.cart_items.push(create(:cart_item))
      @cart.add_items_to_checkout(@order) ##
      @order.order_items.size.should == 3 
      cart = create(:cart_with_two_5_dollar_items)
      cart.add_items_to_checkout(@order)
      @order.order_items.size.should == 2
    end
  end
  
  context ".save_user(u)" do
    it 'should assign the user to the cart' do
      user = create(:user)
      @cart.save_user(user)
      @cart.user.should == user
    end
  end
end

describe Cart, "add_variant" do
  # need to stub variant.sold_out? and_return(false)
  before(:each) do
    @cart = create(:cart_with_two_5_dollar_items)
    @variant = create(:variant)
  end
  
  it 'adds variant to cart' do
    Variant.any_instance.stubs(:quantity_available).returns(10)
    expect{@cart.add_variant(@variant.id)}.to change{
      @cart.cart_items.size
    }.by(1)
  end

  it 'adds quantity of variant to cart' do
    Variant.any_instance.stubs(:quantity_available).returns(10)
    cart_item_size = @cart.cart_items.size
    @cart.add_variant(@variant.id)
    @cart.add_variant(@variant.id)
    @cart.reload.cart_items.each do |item|
      item.quantity.should == 2 if item.variant_id == @variant.id
    end
    @cart.cart_items.size.should == cart_item_size + 1
  end

  it 'adds quantity of variant if out of stock' do
    Variant.any_instance.stubs(:quantity_available).returns(0)
    expect{@cart.add_variant(@variant.id)}.to change {
      @cart.reload.cart_items.size
    }.by(0)
  end
end

describe Cart, ".remove_variant" do
  let(:cart) {create(:cart_with_two_items)}
  it 'should inactivate variant in cart' do
    variant_id = cart.cart_items.first.variant_id
    cart.remove_variant(variant_id)
    expect(cart.cart_items.first.active).to be_false    
  end
end