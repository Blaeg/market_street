require 'spec_helper'

describe Shopping::CartsController do
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

  it "index action renders index template" do
    get :index
    expect(response).to render_template(:index)
  end  
end