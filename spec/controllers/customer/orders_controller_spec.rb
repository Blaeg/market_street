require 'spec_helper'

describe Customer::OrdersController do
  render_views

  before(:each) do
    activate_authlogic

    @user = create(:user)
    login_as(@user)
  end

  it "index action renders index template" do
    @order = create(:order, :user => @user)
    get :index
    response.should render_template(:index)
  end

  it "show action renders show template" do
    @order = build(:order, :user => @user )
    @order.state = 'complete'
    @order.save
    get :show, :id => @order.number
    response.should render_template(:show)
  end

end

describe Customer::OrdersController do
  render_views

  it "index action should go to login page" do
    get :index
    response.should redirect_to(login_url)
  end

  it "show action should go to login page" do
    @order = create(:order)
    @order.state = 'complete'
    @order.save
    get :show, :id => @order.id
    response.should redirect_to(login_url)
  end
end
