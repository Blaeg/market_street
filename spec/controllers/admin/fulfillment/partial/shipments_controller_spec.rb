require 'spec_helper'

describe Admin::Fulfillment::Partial::ShipmentsController do
  render_views


  before(:each) do
    @order = FactoryGirl.create(:order)
    @order_item = FactoryGirl.create(:order_item, :order => @order)
    activate_authlogic
    @user = FactoryGirl.create(:admin_user)
    login_as(@user)
  end

  it "new action renders new template" do
    get :new, :order_id => @order.number
    expect(response).to render_template(:new)
  end

  it "create action renders new template when model is invalid" do
    Order.any_instance.stubs(:create_shipments_with_order_item_ids).returns(false)
    post :create, :order_item_ids => [@order_item.id], :order_id => @order.number
    expect(response).to render_template(:new)
  end

  it "create action redirects when model is valid" do
    Order.any_instance.stubs(:create_shipments_with_order_item_ids).returns(true)
    post :create, :order_item_ids => [@order_item.id], :order_id => @order.number
    expect(response).to redirect_to(edit_admin_fulfillment_order_url( @order ))
  end

  it "update action renders new template when model is invalid" do
    Order.any_instance.stubs(:create_shipments_with_order_item_ids).returns(false)
    put :update, :order => { :order_item_ids => []}, :order_id => @order.number, :id => 0
    expect(response).to render_template(:new)
  end

  it "update action redirects when model is valid" do
    Order.any_instance.stubs(:create_shipments_with_order_item_ids).returns(true)
    put :update, :order => { :order_item_ids => [@order_item.id]}, :order_id => @order.number, :id => 0
    expect(response).to redirect_to(edit_admin_fulfillment_order_url( @order ))
  end
end
