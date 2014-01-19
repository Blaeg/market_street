require 'spec_helper'

describe Shopping::CartItemsController do
  render_views
  let(:user) { create(:user) }
  let(:variant) { create(:variant) }
  
  before do
    activate_authlogic
    login_as(user)
  end

  describe "create" do 
    let(:cart_item_attributes) { { quantity: 1, variant_id: variant.id} }
    it "creates cart item with new quantity" do 
      post :create, :format => :json, cart_item: cart_item_attributes
      expect(CartItem.count).to eq 1
      expect(response).to redirect_to shopping_cart_url
    end
  end

  describe "update" do 
    let(:cart) { create_cart(user, [variant]) }
    let(:cart_item) { cart.cart_items.first }
    
    context "quantity +" do 
      it "updates cart item quantity" do 
        put :update, :id => cart_item.id, :format => :json, 
          cart_item: { quantity: 2 }
        expect(response).to be_success
        expect(cart_item.reload.quantity).to eq 2
      end
    end

    context "quantity =0" do 
      it "deletes cart item quantity" do 
        put :update, :id => cart_item.id, :format => :json, 
          cart_item: { quantity: 0 }
        expect(response).to be_success
        expect(CartItem.count).to eq 0
      end
    end
  end  

  describe "destroy" do 
    let(:cart) { create_cart(user, [variant]) }
    let(:cart_item) { cart.cart_items.first }
    
    it "deletes cart item quantity" do 
      delete :destroy, :id => cart_item.id
      expect(response).to be_success
      expect(CartItem.count).to eq 0
    end
  end
end