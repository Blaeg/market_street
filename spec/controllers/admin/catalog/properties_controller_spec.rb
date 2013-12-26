require 'spec_helper'

describe Admin::Catalog::PropertiesController do
  render_views

  before(:each) do
    activate_authlogic

    @user = create_admin_user
    login_as(@user)

    controller.stubs(:current_ability).returns(Ability.new(@user))
  end

  it "index action renders index template" do
    @property = create(:property)
    get :index
    expect(response).to be_ok
    expect(response).to render_template :index    
  end

  it "new action renders new template" do
    get :new
    expect(response).to be_ok
    expect(response).to render_template :new    
  end

  it "create action renders new template when model is invalid" do
    Property.any_instance.stubs(:valid?).returns(false)
    post :create, :property => {:display_name => 'dis', :identifing_name => 'test'}
    expect(response).to render_template :new
  end

  it "create action should redirect when model is valid" do
    Property.any_instance.stubs(:valid?).returns(true)
    post :create, :property => {:display_name => 'dis', :identifing_name => 'test'}
    expect(response).to redirect_to(admin_catalog_properties_url)
  end

  it "edit action renders edit template" do
    @property = create(:property)
    get :edit, :id => @property.id
    expect(response).to be_ok
    expect(response).to render_template :edit
  end

  it "update action renders edit template when model is invalid" do
    @property = create(:property)
    Property.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @property.id, :property => {:display_name => 'dis', :identifing_name => 'test'}
    expect(response).to render_template :edit
  end

  it "update action should redirect when model is valid" do
    @property = create(:property)
    Property.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @property.id, :property => {:display_name => 'dis', :identifing_name => 'test'}
    expect(response).to redirect_to(admin_catalog_properties_url)
  end

  it "destroy action should destroy model and redirect to index action" do
    @property = create(:property)
    delete :destroy, :id => @property.id
    expect(response).to redirect_to(admin_catalog_properties_url)
    Property.find(@property.id).active.should be_false
  end
end
