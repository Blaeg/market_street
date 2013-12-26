require 'spec_helper'

describe Shopping::CartItemsController do
  render_views

  before(:each) do
    activate_authlogic
    @user = create(:user)
    login_as(@user)

    @variant = create(:variant)
    create_cart(@user, [@variant])    
  end

  it "index action renders index template" do
    get :index
    expect(response).to render_template(:index)
  end

  #todo add test for create and update

  it "destroy action renders index template" do
    delete :destroy, :id => @variant.id
    expect(CartItem.where(variant_id: @variant.id).first).not_to be_active
    expect(response).to redirect_to shopping_cart_items_path
  end
end