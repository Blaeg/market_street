require 'spec_helper'

describe Admin::Catalog::Wizards::ProductsController do
  render_views

  before(:each) do
    activate_authlogic

    @user = create_admin_user
    login_as(@user)
    @property = create(:property)
    controller.session[:product_wizard] = {}
    controller.session[:product_wizard][:brand_id] = 7# @brand.id
    controller.session[:product_wizard][:product_type_id] = 7# @brand.id
    controller.session[:product_wizard][:property_ids]    = [@property.id]    
  end

  it "new action renders new template" do
    get :new
    expect(response).to render_template(:new)
  end

  it "create action renders new template when model is invalid" do
    Product.any_instance.stubs(:valid?).returns(false)
    post :create, :product => { :name => 'hello'}
    expect(response).to render_template(:new)
  end

  it "create action redirects when model is valid" do
    Product.any_instance.stubs(:valid?).returns(true)
    post :create, :product => { :name => 'hello',
                                :permalink => 'hi',
                                :product_type_id => 2                                
                              }
    expect(response).to redirect_to(edit_admin_catalog_products_description_url(assigns[:product]))
  end
end
