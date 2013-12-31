require 'spec_helper'

describe Shopping::CartItemsController do
  render_views

  before(:each) do
    activate_authlogic
    @user = create(:user)
    login_as(@user)

    @variant = create(:variant)
    create_cart(@user, [@variant])        

    @cart = Cart.where(:user_id => @user.id).first
    @cart_item = @cart.cart_items.first
  end

  context "when update" do 
    it "updates cart item quantity and refreshes" do 
      put :update, :id => @cart_item.id, "commit"=>"Update", :format => :json, 
        "cart_item" => { "quantity"=> @cart_item.quantity+1 }
      expect(response).to be_success
    end
  end

  it "destroy action renders index template" do
    delete :destroy, :id => @variant.id
    expect(CartItem.where(variant_id: @variant.id).first).not_to be_active
    expect(response).to redirect_to shopping_cart_path
  end
end