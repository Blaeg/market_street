require 'spec_helper'

describe Admin::Reports::GraphsController do
  # fixtures :all
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

  it "show action renders show template" do
    get :show, :id => 'Orders'
    expect(response).to render_template(:show)
  end
end
