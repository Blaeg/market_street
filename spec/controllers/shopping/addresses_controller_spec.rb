require 'spec_helper'

describe Shopping::AddressesController do
  render_views

  before(:each) do
    activate_authlogic
    @cur_user = create(:user)
    login_as(@cur_user)

    @variant  = create(:variant)
    create_cart(@cur_user, [@variant])
    @shipping_address = create(:address, :addressable_id => @cur_user.id, :addressable_type => 'User')
  end

  it "index action renders index template" do
    get :index
    expect(response).to render_template(:index)
  end

  it "create action renders new template when model is invalid" do
    Address.any_instance.stubs(:valid?).returns(false)
    post :create, :address => @shipping_address.attributes
    expect(response).to render_template(:index)
  end

  it "create action should redirect when model is valid" do
    Address.any_instance.stubs(:valid?).returns(true)
    post :create, :address => @shipping_address.attributes
    expect(response).to redirect_to(shopping_shipping_methods_url)
  end

  it "edit action renders edit template" do
    get :edit, :id => @shipping_address.id
    expect(response).to render_template(:edit)
  end

  it "update action renders edit template when model is invalid" do
    Address.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @shipping_address.id, :address => @shipping_address.attributes
    expect(response).to render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    Address.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @shipping_address.id, :address => @shipping_address.attributes
    expect(response).to redirect_to(shopping_shipping_methods_url)
  end

  it "update action should redirect when model is valid" do
    Address.any_instance.stubs(:valid?).returns(true)
    put :select_address, :id => @shipping_address.id
    expect(response).to redirect_to(shopping_shipping_methods_url)
  end

end
