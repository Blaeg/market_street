require 'spec_helper'

describe Admin::Fulfillment::InvoicesController do
  render_views

  before(:each) do
    activate_authlogic

    @user = create_admin_user
    login_as(@user)
  end

  it "index action renders index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action renders show template" do
    invoice = create(:invoice)
    get :show, :id => invoice.id
    response.should render_template(:show)
  end

end