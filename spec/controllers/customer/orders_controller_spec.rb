require 'spec_helper'

describe Customer::OrdersController do
  render_views
  let(:user) { create(:user) }
  let(:order) { create(:completed_order, :user => user) }

  before(:each) do
    activate_authlogic
    login_as(user)
  end

  it "index action renders index template" do    
    get :index
    expect(response).to render_template(:index)
  end

  it "show action renders show template" do
    order = build(:order, :user => user )
    order.complete!
    get :show, :id => order.number
    expect(response).to render_template(:show)
  end
end

describe Customer::OrdersController do
  render_views
  let(:user) { create(:user) }
  let(:order) { create(:completed_order, :user => user ) }

  it "index action should go to login page" do
    get :index
    expect(response).to redirect_to(login_url)
  end

  it "show action should go to login page" do
    get :show, :id => order.id
    expect(response).to redirect_to(login_url)
  end
end