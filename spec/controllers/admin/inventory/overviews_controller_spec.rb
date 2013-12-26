require 'spec_helper'

describe Admin::Inventory::OverviewsController do
  render_views

  before(:each) do
    activate_authlogic

    @user = create_admin_user
    login_as(@user)
    @product = create(:product)
  end

  it "index action renders index template" do
    get :index
    expect(response).to render_template(:index)
  end

  it "edit action renders edit template" do
    get :edit, :id => @product.id
    expect(response).to render_template(:edit)
  end

  it "update action renders edit template when model is invalid" do
    Product.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @product.id
    expect(response).to render_template(:edit)
  end

  it "update action redirects when model is valid" do
    Product.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @product.id
    expect(response).to redirect_to(admin_inventory_overviews_url())
  end
end
