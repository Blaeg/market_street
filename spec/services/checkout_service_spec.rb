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

    context "ready to checkout" do
      let(:cart) { create(:cart_ready_to_checkout) }      
      subject { CheckoutService.new(cart) }
      
      it "checkouts, saves the order" do           
        placed_order = subject.checkout        
        expect(Order.count).to eq 1      
        expect_cart_and_order_to_be_equal(cart, placed_order)
      end      

      it "clears the cart" do 
        subject.checkout
        expect(cart).not_to be_active
        expect(cart.cart_items.map(&:active?).any?).to be_false        
        expect(cart.user.current_cart).to be_nil        
      end
      
      it "reduces the inventory" do 
        inventories = cart.cart_items.map{|i|i.variant.inventory}
        inventory_quantity = inventories.map(&:count_on_hand).sum
        subject.checkout
        new_inventory_quantity = inventories.map{|i| i.reload.count_on_hand}.sum
        expect(new_inventory_quantity).to eq (inventory_quantity - cart.total_quantity)
      end
    end  
  end
end