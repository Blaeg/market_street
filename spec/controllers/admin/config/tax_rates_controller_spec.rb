require 'spec_helper'

describe Admin::Config::TaxRatesController do
  render_views

  before(:each) do
    activate_authlogic
    @user = FactoryGirl.create(:super_admin_user)
    login_as(@user)
  end

  it "index action renders index template" do
    get :index
    expect(response).to render_template(:index)
  end

  it "show action renders show template" do
    @tax_rate = FactoryGirl.create(:tax_rate)
    get :show, :id => @tax_rate.id
    expect(response).to render_template(:show)
  end

  it "new action renders new template" do
    get :new
    expect(response).to render_template(:new)
  end

  it "create action renders new template when model is invalid" do
    TaxRate.any_instance.stubs(:valid?).returns(false)
    post :create, :tax_rate => { :start_date => Time.now.to_s(:db), :state_id => 1}
    expect(response).to render_template(:new)
  end

  it "create action redirects when model is valid" do
    TaxRate.any_instance.stubs(:valid?).returns(true)
    post :create, :tax_rate => { :start_date => Time.now.to_s(:db), :state_id => 1}
    expect(response).to redirect_to(admin_config_tax_rate_url(assigns[:tax_rate]))
  end

  it "edit action renders edit template" do
    @tax_rate = create(:tax_rate)
    get :edit, :id => @tax_rate.id
    expect(response).to render_template(:edit)
  end

  it "update action renders edit template when model is invalid" do
    @tax_rate = create(:tax_rate)
    TaxRate.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @tax_rate.id, :tax_rate => { :start_date => Time.now.to_s(:db), :state_id => 1}
    expect(response).to render_template(:edit)
  end

  it "update action redirects when model is valid" do
    @tax_rate = create(:tax_rate)
    TaxRate.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @tax_rate.id, :tax_rate => { :start_date => Time.now.to_s(:db), :state_id => 1}
    expect(response).to redirect_to(admin_config_tax_rate_url(assigns[:tax_rate]))
  end

  it "destroy action should destroy model and redirect to index action" do
    @tax_rate = create(:tax_rate)
    delete :destroy, :id => @tax_rate.id
    expect(response).to redirect_to(admin_config_tax_rates_url)
    TaxRate.find(@tax_rate.id).active.should be_false
  end
end
