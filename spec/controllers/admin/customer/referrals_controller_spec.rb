require 'spec_helper'

describe Admin::Customer::ReferralsController do
  render_views

  before(:each) do
    activate_authlogic
    @cur_user = FactoryGirl.create(:admin_user)
    login_as(@cur_user)
  end

  it "index action renders index template" do
    referral = FactoryGirl.create(:referral)
    get :index
    expect(response).to render_template(:index)
  end

  it "show action renders show template" do
    referral = FactoryGirl.create(:referral)
    get :show, :id => referral.id
    expect(response).to render_template(:show)
  end

  it "new action renders new template" do
    get :new
    expect(response).to render_template(:new)
  end

  it "create action renders new template when model is invalid" do
    referral = FactoryGirl.build(:referral)
    Referral.any_instance.stubs(:valid?).returns(false)
    post :create, :referral => referral.attributes.reject {|k,v| ['id','applied','clicked_at','purchased_at', 'referral_user_id', 'referring_user_id', 'registered_at','sent_at', 'created_at', 'updated_at'].include?(k)}
    expect(response).to render_template(:new)
  end

  it "create action renders new template when wrong email given " do
    @ref_user = FactoryGirl.create(:user)
    referral = FactoryGirl.build(:referral)
    Referral.any_instance.stubs(:valid?).returns(true)
    post :create, :referral => referral.attributes.reject {|k,v| ['id','applied','clicked_at','purchased_at', 'referral_user_id', 'referring_user_id', 'registered_at','sent_at', 'created_at', 'updated_at'].include?(k)}, :referring_user_email => 'blah'
    expect(response).to render_template(:new)
  end

  it "create action redirects when model is valid" do
    @ref_user = FactoryGirl.create(:user)
    referral = FactoryGirl.build(:referral)
    Referral.any_instance.stubs(:valid?).returns(true)
    post :create, :referral => referral.attributes.reject {|k,v| ['id','applied','clicked_at','purchased_at', 'referral_user_id', 'referring_user_id', 'registered_at','sent_at', 'created_at', 'updated_at'].include?(k)}, :referring_user_email => @ref_user.email
    expect(response).to redirect_to(admin_customer_referral_url(assigns[:referral]))
  end

  it "edit action renders edit template" do
    referral = FactoryGirl.create(:referral)
    get :edit, :id => referral.id
    expect(response).to render_template(:edit)
  end

  it "update action renders edit template when model is invalid" do
    referral = FactoryGirl.create(:referral)
    Referral.any_instance.stubs(:valid?).returns(false)
    put :update, :id => referral.id, :referral => referral.attributes.reject {|k,v| ['id','applied','clicked_at','purchased_at', 'referral_user_id', 'referring_user_id', 'registered_at','sent_at', 'created_at', 'updated_at'].include?(k)}
    expect(response).to render_template(:edit)
  end

  it "update action redirects when model is valid" do
    referral = FactoryGirl.create(:referral)
    Referral.any_instance.stubs(:valid?).returns(true)
    put :update, :id => referral.id, :referral => referral.attributes.reject {|k,v| ['id','applied','clicked_at','purchased_at', 'referral_user_id', 'referring_user_id', 'registered_at','sent_at', 'created_at', 'updated_at'].include?(k)}
    expect(response).to redirect_to(admin_customer_referral_url(assigns[:referral]))
  end

  it "destroy action should destroy model and redirect to index action" do
    referral = FactoryGirl.create(:referral)
    delete :destroy, :id => referral.id
    expect(response).to redirect_to(admin_customer_referrals_url)
    Referral.exists?(referral.id).should be_false
  end
end
