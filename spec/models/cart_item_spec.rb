require 'spec_helper'

describe CartItem do
  context "CartItem" do
    before(:each) do
      @cart_item = build(:cart_item)
    end
    
    it "is valid with minimum attributes" do
      @cart_item.should be_valid
    end
    
  end
  
end

describe Cart, " instance methods" do
  before(:each) do
    @cart_item = create(:five_dollar_cart_item)    
  end
  context " price" do
    it 'has a price of the variant which is 5 dollars' do
      @cart_item.price.should == 5.0
    end
  end
  
  context " total" do
    it 'has a total price of 2 times 5 dollars' do
      @cart_item.stubs(:quantity).returns(2)
      @cart_item.total.should == 10.0
    end
  end
  
  context " inactivate!" do
    it 'is not active' do
      @cart_item.inactivate!
      @cart_item.active.should == false
    end
  end
  
  context " active" do
    it 'is created active' do
      expect(@cart_item.active).to be_true      
    end
    it 'is not active after inactivation' do
      @cart_item.inactivate!
      expect(@cart_item.active).to be_false      
    end
  end
end