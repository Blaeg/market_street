require 'spec_helper'

describe Shopping::BillingAddressesController do
  render_views

  before(:each) do
    activate_authlogic
    @cur_user = create(:user)
    login_as(@cur_user)

    @variant  = create(:variant)
    create_cart(@cur_user, [@variant])
    @bill_address = create(:address, :addressable_id => @cur_user.id, :addressable_type => 'User')
  end

  it "index action renders index template" do
    get :index
    expect(response).to render_template(:index)
  end

  it "create action renders new template when model is invalid" do
    Address.any_instance.stubs(:valid?).returns(false)
    post :create, :address => @bill_address.attributes
    expect(response).to render_template(:index)
  end

  it "create action redirects when model is valid" do
    Address.any_instance.stubs(:valid?).returns(true)
    controller.stubs(:next_form_url).returns(shopping_orders_path)
    post :create, :address => @bill_address.attributes
    expect(response).to redirect_to(shopping_orders_path)
  end

  it "edit action renders edit template" do
    get :edit, :id => @bill_address.id
    expect(response).to render_template(:edit)
  end

  it "update action renders edit template when model is invalid" do
    Address.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @bill_address.id, :address => @bill_address.attributes
    expect(response).to render_template(:edit)
  end

  it "update action redirects when model is valid" do
    Address.any_instance.stubs(:valid?).returns(true)
    controller.stubs(:next_form_url).returns(shopping_orders_path)
    put :update, :id => @bill_address.id, :address => @bill_address.attributes
    expect(response).to redirect_to(shopping_orders_path)
  end

  it "update action redirects when model is valid" do
    Address.any_instance.stubs(:valid?).returns(true)
    controller.stubs(:next_form_url).returns(shopping_orders_path)
    put :select_address, :id => @bill_address.id
    expect(response).to redirect_to(shopping_orders_path)
  end
end
