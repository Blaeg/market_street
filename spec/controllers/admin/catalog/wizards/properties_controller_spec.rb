require 'spec_helper'

describe Admin::Catalog::Wizards::PropertiesController do
  render_views

  before(:each) do
    activate_authlogic

    @user = create_admin_user
    login_as(@user)
    controller.session[:product_wizard] = {}
    controller.session[:product_wizard][:brand_id] = 7# @brand.id
    controller.session[:product_wizard][:product_type_id] = 7# @brand.id
  end

  it "index action renders index template" do
    get :index
    expect(response).to render_template(:index)
  end

  it "create action renders new template when model is invalid" do
    Property.any_instance.stubs(:valid?).returns(false)
    post :create, :property => {:identifing_name => 'test', :display_name => 'test'}
    expect(response).to render_template(:index)
  end

  it "create action redirects when model is valid" do
    Property.any_instance.stubs(:valid?).returns(true)
    post :create, :property => {:identifing_name => 'test', :display_name => 'test'}
    expect(response).to render_template(:index)
  end

  it "update action renders edit template when model is invalid" do
    @property = create(:property)
    put :update, :id => @property.id, :property => {:ids => [ ]}
    expect(response).to render_template(:index)
  end

  it "update action redirects when model is valid" do
    @property = create(:property)
    put :update, :id => @property.id, :property => {:ids => [ @property.id ]}
    controller.session[:product_wizard][:property_ids].should == [@property.id]
  end
end
