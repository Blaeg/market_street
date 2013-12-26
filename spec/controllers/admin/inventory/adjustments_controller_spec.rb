require 'spec_helper'

describe Admin::Inventory::AdjustmentsController do
  render_views

  before(:each) do
    activate_authlogic

    @user = create_admin_user
    login_as(@user)
    @product = create(:product)
  end

  it "show action renders show template" do
    @product = create(:product)
    get :show, :id => @product.id
    expect(response).to render_template(:show)
  end

  it "index action renders index template" do
    @product = create(:product)
    get :index
    expect(response).to render_template(:index)
  end

  it "edit action renders edit template" do
    @variant = create(:variant)
    get :edit, :id => @variant.id
    expect(response).to render_template(:edit)
  end

  it "update action renders edit template when model is invalid" do
    @variant = create(:variant)
    Variant.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @variant.id
    expect(response).to render_template(:edit)
  end

  it "update action renders edit when no refund is passed" do
    @product = create(:product)
    @variant = create(:variant, :product => @product)
    Variant.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @variant.id, :variant => {:qty_to_add => '-3'}
    expect(response).to render_template(:edit)
  end

  it "update action redirects when model is valid" do
    @product = create(:product)
    @variant = create(:variant, :product => @product)
    Variant.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @variant.id, :variant => {:qty_to_add => '-3'}, :refund => '12.09'
    expect(response).to redirect_to(admin_inventory_adjustment_url(@product))
  end

  it "update action redirects when model is valid" do
    @product = create(:product)
    @variant = create(:variant, :product => @product)
    Variant.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @variant.id, :variant => {:qty_to_add => '-3'}, :refund => '00.0'
    expect(response).to redirect_to(admin_inventory_adjustment_url(@product))
  end
end
