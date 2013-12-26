require 'spec_helper'

describe Admin::Catalog::VariantsController do
  render_views

  before(:each) do
    activate_authlogic

    @user = create_admin_user
    login_as(@user)
    @product = create(:product)
  end

  it "index action renders index template" do
    @variant = create(:variant, :product => @product)
    get :index, :product_id => @product.id
    expect(response).to render_template(:index)
  end

  it "show action renders show template" do
    @variant = create(:variant, :product => @product)
    get :show, :id => @variant.id, :product_id => @product.id
    expect(response).to render_template(:show)
  end

  it "new action renders new template" do
    get :new, :product_id => @product.id
    expect(response).to render_template(:new)
  end
#require(:variant).permit(:product_id, :sku, :name, :price, :cost, :deleted_at, :master, :brand_id, :inventory_id )
  it "create action renders new template when model is invalid" do
    Variant.any_instance.stubs(:valid?).returns(false)
    post :create, :product_id => @product.id, :variant => {:sku => '1232-abc', :name => 'variant name', :price => '20.00', :cost => '10.00', :deleted_at => nil, :master => false, :brand_id => 1}
    expect(response).to render_template(:new)
  end

  it "create action redirects when model is valid" do
    Variant.any_instance.stubs(:valid?).returns(true)
    post :create, :product_id => @product.id, :variant => {:sku => '1232-abc', :name => 'variant name', :price => '20.00', :cost => '10.00', :deleted_at => nil, :master => false, :brand_id => 1}
    expect(response).to redirect_to(admin_catalog_product_variants_url(@product))
  end

  it "edit action renders edit template" do
    @variant = create(:variant, :product => @product)
    get :edit, :id => @variant.id, :product_id => @product.id
    expect(response).to render_template(:edit)
  end

  it "update action renders edit template when model is invalid" do
    @variant = create(:variant, :product => @product)
    Variant.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @variant.id, :product_id => @product.id, :variant => {:sku => '1232-abc', :name => 'variant name', :price => '20.00', :cost => '10.00', :deleted_at => nil, :master => false, :brand_id => 1}
    expect(response).to render_template(:edit)
  end

  it "update action redirects when model is valid" do
    @variant = create(:variant, :product => @product)
    Variant.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @variant.id, :product_id => @product.id, :variant => {:sku => '1232-abc', :name => 'variant name', :price => '20.00', :cost => '10.00', :deleted_at => nil, :master => false, :brand_id => 1}
    expect(response).to redirect_to(admin_catalog_product_variants_url(@variant.product))
  end

  it "destroy action should destroy model and redirect to index action" do
    @variant = create(:variant, :product => @product)
    delete :destroy, :id => @variant.id, :product_id => @product.id
    expect(response).to redirect_to(admin_catalog_product_variants_url(@product))
    Variant.find(@variant.id).deleted_at.should_not be_nil
  end
end
