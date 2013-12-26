require 'spec_helper'

describe Customer::AddressesController do
  render_views

  before(:each) do
    activate_authlogic
    @user = create(:user)
    login_as(@user)
  end

  it "index action renders index template" do
    get :index
    expect(response).to render_template(:index)
  end

  it "show action renders show template" do
    @address = create(:address, :addressable => @user)
    get :show, :id => @address.id
    expect(response).to render_template(:show)
  end

  it "new action renders new template" do
    get :new
    expect(response).to render_template(:new)
  end

  it "create action renders new template when model is invalid" do
    Address.any_instance.stubs(:valid?).returns(false)
    address = build(:address)
    post :create, :address => address.attributes
    expect(response).to render_template(:new)
  end

  it "create action redirects when model is valid" do
    Address.any_instance.stubs(:valid?).returns(true)
    address = build(:address)
    post :create, :address => address.attributes
    expect(response).to redirect_to(customer_address_url(assigns[:address]))
  end

  it "edit action renders edit template" do
    @address = create(:address, :addressable => @user)
    get :edit, :id => @address.id
    expect(response).to render_template(:edit)
  end

  it "update action renders edit template when model is invalid" do
    @address = create(:address, :addressable => @user)
    Address.any_instance.stubs(:valid?).returns(false)
    address = build(:address, :default => true)
    put :update, :id => @address.id, :address => address.attributes
    expect(response).to render_template(:edit)
  end

  it "update action redirects when model is valid" do
    @address = create(:address, :addressable => @user)
    Address.any_instance.stubs(:valid?).returns(true)
    address = build(:address, :default => true)
    put :update, :id => @address.id, :address => address.attributes
    expect(response).to redirect_to(customer_address_url(assigns[:address]))
  end

  it "destroy action should destroy model and redirect to index action" do
    @address = create(:address, :addressable => @user)
    delete :destroy, :id => @address.id
    expect(response).to redirect_to(customer_addresses_url)
    Address.exists?(@address.id).should be_true
    a = Address.find(@address.id)
    a.active.should be_false
  end
end
