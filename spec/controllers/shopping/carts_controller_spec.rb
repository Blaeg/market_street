require 'spec_helper'

describe Shopping::CartsController do
  render_views

  let(:user) { create(:user) }
  let(:variant) { create(:variant) }
  let(:cart) { create_cart(user, [variant])}
  
  before(:each) do
    activate_authlogic
    login_as(user)  
  end

  it "index action renders index template" do
    get :index
    expect(response).to render_template(:index)
  end  

  it "index action renders index template" do
    get :checkout
    expect(response).to render_template(:checkout)
  end  
end