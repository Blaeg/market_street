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