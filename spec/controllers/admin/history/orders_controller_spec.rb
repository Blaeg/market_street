require 'spec_helper'

describe Admin::History::OrdersController do
  render_views

  before(:each) do
    activate_authlogic
    @user = create_admin_user
    login_as(@user)
  end

  it "show action renders show template" do
    @order = create(:order)
    get :show, :id => @order.number
    response.should render_template(:show)
  end

  it "index action renders index template" do
    get :index
    response.should render_template(:index)
  end
end
