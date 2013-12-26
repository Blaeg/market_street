require 'spec_helper'

describe Customer::OverviewsController do
  render_views

  before(:each) do
    activate_authlogic

    @user = create(:user)
    login_as(@user)
  end

  it "show action renders show template" do
    get :show
    expect(response).to render_template(:show)
  end

  it "show action renders show template" do
    @address = create(:address, :addressable => @user)
    @user.stubs(:shipping_address).returns(@address)
    get :show
    expect(response).to render_template(:show)
  end

  it "edit action renders edit template" do
    get :edit
    expect(response).to render_template(:edit)
  end

  it "update action renders edit template when model is invalid" do
    User.any_instance.stubs(:valid?).returns(false)
    put :update, :user => @user.attributes.reject {|k,v| ![ 'first_name', 'last_name', 'password'].include?(k)}
    expect(response).to render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    User.any_instance.stubs(:valid?).returns(true)
    put :update, :user => @user.attributes.reject {|k,v| ![ 'first_name', 'last_name', 'password'].include?(k)}
    expect(response).to redirect_to(customer_overview_url())
  end
end

describe Customer::OverviewsController do
  render_views

  it "not logged in should redirect to login page" do
    get :show
    expect(response).to redirect_to(login_url)
  end
end
