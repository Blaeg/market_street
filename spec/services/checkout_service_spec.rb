require 'spec_helper'

describe CheckoutService do
  describe "new_order" do
    let(:cart) { create(:cart_with_items) }
    subject { CheckoutService.new(cart) }
    
    it "builds new order" do
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

  describe "checkout" do 
    context "not ready" do 
      let(:cart) { create(:cart_with_items) }
      subject { CheckoutService.new(cart) }

      it "doesn't checkout" do 
        expect(Order.count).to eq 0
        subject.checkout
        expect(Order.count).to eq 0
      end
    end
    
    context "errorous" do 
      let(:cart) { create(:cart_with_items) }
      subject { CheckoutService.new(cart) }

      it "doesn't checkout" do 
        expect(Order.count).to eq 0
        subject.checkout
        expect(Order.count).to eq 0
      end
    end

    context "ready" do 
      let(:cart) { create(:cart_ready_to_checkout) }
      subject { CheckoutService.new(cart) }
      
      it "checkouts, saves the new order to db" do 
        expect(Order.count).to eq 0
        subject.checkout
        expect(Order.count).to eq 1      
      end
    end
  end
end