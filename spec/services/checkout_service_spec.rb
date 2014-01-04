require 'spec_helper'

describe CheckoutService do
  describe "new_order" do
    let(:cart) { create(:cart_with_two_items) }
    subject { CheckoutService.new(cart) }
    
    it "creates new order" do
      order = subject.new_order
      expect(order.class).to eq Order

      expect(order.cart_id).to eq cart.id
      
      expect(order.calculated_at).not_to be_nil
      expect(order.total_amount).to eq cart.total_amount
      expect(order.tax_amount).to eq cart.tax_amount
      expect(order.shipping_amount).to eq cart.shipping_amount
      expect(order.credit_amount).to eq cart.credit_amount
    end    
  end  
end