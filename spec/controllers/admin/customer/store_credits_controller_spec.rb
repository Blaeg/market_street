require 'spec_helper'

describe Admin::Customer::StoreCreditsController do
  render_views
  
  before(:each) do
    activate_authlogic
    @cur_user = FactoryGirl.create(:admin_user)
    login_as(@cur_user)
    @user = FactoryGirl.create(:user)
  end

  it "show action renders show template" do
    get :show, :user_id => @user.id
    expect(response).to render_template(:show)
  end

  it "edit action renders edit template" do
    get :edit, :user_id => @user.id
    expect(response).to render_template(:edit)
  end

  it "update action renders edit template when model is invalid" do
    put :update, :user_id => @user.id, :amount_to_add => 'ABC'
    expect(response).to render_template(:edit)
  end

  it "update action redirects when model is valid" do
    StoreCredit.any_instance.stubs(:valid?).returns(true)
    put :update, :user_id => @user.id, :amount_to_add => '20.0'
    expect(response).to redirect_to(admin_customer_user_store_credits_url(@user))
  end
  it "update action redirects when model is valid" do
    StoreCredit.any_instance.stubs(:valid?).returns(true)
    put :update, :user_id => @user.id, :amount_to_add => '-20.00'
    expect(response).to redirect_to(admin_customer_user_store_credits_url(@user))
  end
end
