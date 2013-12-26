require 'spec_helper'

describe Admin::Config::ShippingRatesController do
  render_views

  before(:each) do
    activate_authlogic

    @user = FactoryGirl.create(:super_admin_user)
    login_as(@user)
  end

  it "index action renders index template" do
    ShippingMethod.stubs(:all).returns([])
    get :index
    expect(response).to redirect_to(admin_config_shipping_methods_url)
  end

  it "index action renders index template" do
    shipping_method = FactoryGirl.create(:shipping_method)
    ShippingMethod.stubs(:all).returns([shipping_method])
    get :index
    expect(response).to render_template(:index)
  end

  it "show action renders show template" do
    @shipping_rate = FactoryGirl.create(:shipping_rate)
    get :show, :id => @shipping_rate.id
    expect(response).to render_template(:show)
  end

  it "new action renders new template" do
    get :new
    expect(response).to render_template(:new)
  end

  it "new action renders new template" do
    ShippingMethod.stubs(:all).returns([])
    get :new
    expect(response).to redirect_to(new_admin_config_shipping_method_url)
  end

  it "new action renders new template" do
    shipping_method = create(:shipping_method)
    ShippingMethod.stubs(:all).returns([shipping_method])
    get :new
    expect(response).to render_template(:new)
  end

  it "create action renders new template when model is invalid" do
    ShippingRate.any_instance.stubs(:valid?).returns(false)
    post :create, :shipping_rate =>  {:shipping_method_id => 1, :shipping_rate_type_id => 1}
    expect(response).to render_template(:new)
  end

  it "create action redirects when model is valid" do
    ShippingRate.any_instance.stubs(:valid?).returns(true)
    post :create, :shipping_rate =>  {:shipping_method_id => 1, :shipping_rate_type_id => 1}
    expect(response).to redirect_to(admin_config_shipping_rate_url(assigns[:shipping_rate]))
  end

  it "edit action renders edit template" do
    @shipping_rate = create(:shipping_rate)
    get :edit, :id => @shipping_rate.id
    expect(response).to render_template(:edit)
  end

  it "update action renders edit template when model is invalid" do
    @shipping_rate = create(:shipping_rate)
    ShippingRate.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @shipping_rate.id, :shipping_rate =>  { :shipping_method_id => 1, :shipping_rate_type_id => 1}
    expect(response).to render_template(:edit)
  end

  it "update action redirects when model is valid" do
    @shipping_rate = create(:shipping_rate)
    ShippingRate.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @shipping_rate.id, :shipping_rate =>  { :shipping_method_id => 1, :shipping_rate_type_id => 1}
    expect(response).to redirect_to(admin_config_shipping_rate_url(assigns[:shipping_rate]))
  end

end
