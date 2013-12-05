require 'spec_helper'

describe ShippingRate, 'instance methods' do
  before(:each) do
    @shipping_rate = build(:shipping_rate, :rate => 5.50)
  end

  context ".individual?" do
    it "returns true" do
      @shipping_rate.shipping_rate_type = 'INDIVIDUAL'
      @shipping_rate.individual?.should be_true
    end

    it "returns true" do
      @shipping_rate.shipping_rate_type = 'ORDER'
      @shipping_rate.individual?.should be_false
    end
  end

  context ".name" do
    it "returns the name" do
      @shipping_rate.shipping_rate_type = 'INDIVIDUAL'
      shipping_method = create(:shipping_method, :name => 'shipname')
      @shipping_rate.shipping_method = shipping_method
      @shipping_rate.name.should == 'shipname, (INDIVIDUAL - 5.5)'
    end
  end

  context ".sub_name" do
    it "returns the sub_name" do
      @shipping_rate.shipping_rate_type = 'INDIVIDUAL'
      @shipping_rate.sub_name.should == '(INDIVIDUAL - 5.5)'
    end
  end

  context ".name_with_rate" do
    it "returns the name_with_rate" do
      shipping_method = create(:shipping_method, :name => 'shipname')
      @shipping_rate.shipping_method = shipping_method
      @shipping_rate.stubs(:individual?).returns(false)
      @shipping_rate.name_with_rate.should == 'shipname - $5.50'
    end
    it "returns the name_with_rate" do
      shipping_method = create(:shipping_method, :name => 'shipname')
      @shipping_rate.shipping_method = shipping_method
      @shipping_rate.stubs(:individual?).returns(true)
      @shipping_rate.name_with_rate.should == 'shipname - $5.50 / item'
    end
  end
end

