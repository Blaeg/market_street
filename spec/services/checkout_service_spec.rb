require 'spec_helper'

describe CheckoutService do
  describe "build_new_order" do
    let(:cart) { create(:cart_with_items) }
    subject { CheckoutService.new(cart) }
    
    it "builds new order" do
      order = subject.build_new_order
      expect(order.class).to eq Order

      expect_cart_and_order_to_be_equal(cart, order)
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
        placed_order = subject.checkout
        expect(Order.count).to eq 1      

        expect_cart_and_order_to_be_equal(cart, placed_order)                      
      end
    end
  end
end