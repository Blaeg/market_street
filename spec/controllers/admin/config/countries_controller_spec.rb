require 'spec_helper'

describe Admin::Config::CountriesController do
  render_views

  before(:each) do
    FactoryGirl.create(:country)
    activate_authlogic
    @user = FactoryGirl.create(:super_admin_user)
    login_as(@user)
  end

  it "index action renders index template" do
    get :index
    expect(response).to render_template(:index)
  end

  it "update action redirects and make the country active" do
    country = Country.first()
    country.update_attribute(:active,  false)
    Country.any_instance.stubs(:valid?).returns(true)
    put :update, :id => country.id, :country => country.attributes
    country.reload
    country.active.should be_true
    expect(response).to redirect_to(admin_config_countries_url)
  end

  it "destroy action should make the country inactive and redirect to index action" do
    country = Country.first()
    country.update_attribute(:active,  true)
    delete :destroy, :id => country.id
    expect(response).to redirect_to(admin_config_countries_url)
    country.reload
    country.active.should be_false
  end
end
