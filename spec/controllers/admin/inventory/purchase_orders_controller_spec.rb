require 'spec_helper'

describe Admin::Inventory::PurchaseOrdersController do
  render_views

  before(:each) do
    activate_authlogic

    @user = create_admin_user
    login_as(@user)
  end


  it "index action renders index template" do
    get :index
    expect(response).to render_template(:index)
  end

  it "new action renders new template" do
    create(:supplier)
    get :new
    expect(response).to render_template(:new)
  end

  it "create action renders new template when model is invalid" do
    PurchaseOrder.any_instance.stubs(:valid?).returns(false)
    post :create, :purchase_order => {:ordered_at => Time.now.to_s(:db), :supplier_id => '1'}
    expect(response).to render_template(:new)
  end

  it "create action redirects when model is valid" do
    PurchaseOrder.any_instance.stubs(:valid?).returns(true)
    post :create, :purchase_order => {:ordered_at => Time.now.to_s(:db), :supplier_id => '1'}
    expect(response).to redirect_to(admin_inventory_purchase_orders_url(:notice => 'Purchase order was successfully created.'))
  end

  it "edit action renders edit template" do
    @purchase_order = create(:purchase_order)
    get :edit, :id => @purchase_order.id
    expect(response).to render_template(:edit)
  end

  it "update action renders edit template when model is invalid" do
    @purchase_order = create(:purchase_order)
    PurchaseOrder.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @purchase_order.id, :purchase_order => {:ordered_at => Time.now.to_s(:db), :supplier_id => '1'}
    expect(response).to render_template(:edit)
  end

  it "update action redirects when model is valid" do
    @purchase_order = create(:purchase_order)
    PurchaseOrder.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @purchase_order.id, :purchase_order => {:ordered_at => Time.now.to_s(:db), :supplier_id => '1'}
    expect(response).to redirect_to(admin_inventory_purchase_orders_url(:notice => 'Purchase order was successfully updated.'))
  end

  it "destroy action should destroy model and redirect to index action" do
    @purchase_order = create(:purchase_order)
    delete :destroy, :id => @purchase_order.id
    expect(response).to redirect_to(admin_inventory_purchase_orders_url)
    PurchaseOrder.exists?(@purchase_order.id).should be_false
  end
end
