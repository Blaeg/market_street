require 'spec_helper'

describe OrderItem, "instance methods" do
  let(:order_item) { create(:order_item) }
  
  context ".calculate_order" do
    xit 'calculate order once after calling method twice' do
      order     = mock()
      order_item.stubs(:ready_to_calculate?).returns(true)
      order_item.stubs(:order).returns(order)
      order_item.calculate_order
      order_item.calculate_order
    end
  end  
end

describe OrderItem, "Without VAT" do
  before(:all) do
    Settings.vat = false
  end
  
  context ".calculate_total(coupon = nil)" do
    xit 'calculate_total' do
      order_item = create(:order_item, :price => 20.00)
      order_item.calculate_total
      order_item.total.should == 20.00
    end
  end  
end