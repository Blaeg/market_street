require 'spec_helper'

describe Admin::Customer::AddressesController do
  # fixtures :all
  render_views
  before(:each) do
    activate_authlogic
    @cur_user = FactoryGirl.create(:admin_user)
    login_as(@cur_user)
    @customer = FactoryGirl.create(:user)
  end

  it "index action renders index template" do
    address = FactoryGirl.create(:address, :addressable_id => @customer.id, :addressable_type => 'User')
    get :index, user_id: @customer.id
    expect(response).to render_template(:index)
  end

  it "show action renders show template" do
    address = FactoryGirl.create(:address, :addressable_id => @customer.id, :addressable_type => 'User')
    get :show, id: address.id, user_id: @customer.id
    expect(response).to render_template(:show)
  end

  it "new action renders new template" do
    get :new, user_id: @customer.id
    expect(response).to render_template(:new)
  end

  it "create action renders new template when model is invalid" do
    address = FactoryGirl.build(:address, :addressable_id => @customer.id, :addressable_type => 'User')
    Address.any_instance.stubs(:valid?).returns(false)
    post :create, user_id: @customer.id, :address => address.attributes.reject {|k,v| ['id'].include?(k)}
    expect(response).to render_template(:new)
  end

  it "create action should redirect when model is valid" do
    address = FactoryGirl.build(:address, :addressable_id => @customer.id, :addressable_type => 'User')
    Address.any_instance.stubs(:valid?).returns(true)
    post :create, user_id: @customer.id, :address => address.attributes.reject {|k,v| ['id'].include?(k)}
    expect(response).to redirect_to(admin_customer_user_address_url(@customer, assigns[:address]))
  end

  it "edit action renders edit template" do
    address = FactoryGirl.create(:address, :addressable_id => @customer.id, :addressable_type => 'User')
    get :edit, user_id: @customer.id, :id => address.id
    expect(response).to render_template(:edit)
  end

  it "update action renders edit template when model is invalid" do
    address = FactoryGirl.create(:address, :addressable_id => @customer.id, :addressable_type => 'User')
    Address.any_instance.stubs(:valid?).returns(false)
    put :update, user_id: @customer.id, :id => address.id, :address => address.attributes.reject {|k,v| ['id'].include?(k)}
    expect(response).to render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    address = FactoryGirl.create(:address, :addressable_id => @customer.id, :addressable_type => 'User')
    Address.any_instance.stubs(:valid?).returns(true)
    put :update, user_id: @customer.id, :id => address.id, :address => address.attributes.reject {|k,v| ['id'].include?(k)}
    expect(response).to redirect_to(admin_customer_user_address_url(@customer, assigns[:address]))
  end

  it "destroy action should destroy model and redirect to index action" do
    address = FactoryGirl.create(:address, :addressable_id => @customer.id, :addressable_type => 'User')
    delete :destroy, user_id: @customer.id, :id => address.id
    expect(Address.find(address.id).active).to be_false
  end
end
