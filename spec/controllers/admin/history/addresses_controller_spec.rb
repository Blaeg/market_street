require 'spec_helper'

describe Admin::History::AddressesController do
  render_views

  before(:each) do
    activate_authlogic
    @user = create_admin_user
    login_as(@user)
    @order = create(:order)
  end

  it "index action renders index template" do
    get :index, :order_id => @order.number
    expect(response).to render_template(:index)
  end

  it "show action renders show template" do
    @address = create(:address)
    get :show, :id => @address.id, :order_id => @order.number
    expect(response).to render_template(:show)
  end

  it "new action renders new template" do
    get :new, :order_id => @order.number
    expect(response).to render_template(:new)
  end

  it "create action renders new template when model is invalid" do
    Address.any_instance.stubs(:valid?).returns(false)
    address = build(:address)
    post :create, :order_id => @order.number, :address => address.attributes
    expect(response).to render_template(:new)
  end

  it "create action redirects when model is valid" do
    @address = build(:address)
    Address.any_instance.stubs(:valid?).returns(true)
    post :create, :order_id => @order.number,:address => @address.attributes
    expect(response).to redirect_to(admin_history_order_url(@order))
  end

  it "edit action renders edit template" do
    @address = create(:address)
    get :edit, :id => @address.id, :order_id => @order.number
    expect(response).to render_template(:edit)
  end

  it "update action renders edit template when model is invalid" do
    @address = create(:address)
    Order.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @address.id, :order_id => @order.number
    expect(response).to render_template(:edit)
  end

  it "update action redirects when model is valid" do
    @address = create(:address)
    Address.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @address.id, :order_id => @order.number
    expect(response).to redirect_to(admin_history_order_url(@order))
  end

end
