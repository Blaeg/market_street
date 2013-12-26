require 'spec_helper'

describe Admin::ReportsController do
  render_views
  
  before(:each) do
    activate_authlogic
    @user = create_admin_user
    login_as(@user)
  end

  it "show action renders show template" do
    get :dashboard
    expect(response).to render_template(:dashboard)
  end
end
