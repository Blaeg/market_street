require 'spec_helper'

describe Admin::Inventory::ReceivingsController do
  render_views

  before(:each) do
    activate_authlogic

    @user = create_admin_user
    login_as(@user)
    @purchase_order = create(:purchase_order)
  end

  it "index action renders index template" do
    get :index
    expect(response).to render_template(:index)
  end

  it "edit action renders edit template" do
    get :edit, :id => @purchase_order.id
    expect(response).to render_template(:edit)
  end

  it "update action redirects when model is valid" do
    PurchaseOrder.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @purchase_order.id, :purchase_order => {:receive_po => '1'}
    expect(response).to redirect_to(admin_inventory_receivings_url( :notice => 'Purchase order was successfully updated.'))
  end
end
