require 'spec_helper'

describe Shopping::CartsController do
  render_views

  let(:user) { create(:user) }
  let(:variant) { create(:variant) }
  
  before(:each) do
    activate_authlogic
    login_as(user)
    @cart = create_cart(user, [variant])
  end

  it "index action renders index template" do
    get :index
    expect(response).to render_template(:index)
  end  

  it "review action renders review template" do 
    get :review
    expect(response).to render_template(:review)
  end

  describe "select_ship_address" do
    let(:ship_address) { create(:ship_address, :addressable => user)}
    it "selects ship address to cart" do 
      post :select_ship_address, :ship_address_id => ship_address.id
      expect(response).to be_success
      expect(@cart.reload.ship_address_id).to eq ship_address.id
    end
  end

  describe "select_bill_address" do 
    let(:bill_address) { create(:bill_address, :addressable => user)}
    it "selects bill address to cart" do 
      post :select_bill_address, :bill_address_id => bill_address.id
      expect(response).to be_success
      expect(@cart.reload.bill_address_id).to eq bill_address.id
    end
  end

  describe "checkout" do
    let(:cart) { create(:cart_ready_to_checkout) }      
    let(:order) { create(:order) }
    it "index action renders index template" do
      post :checkout
      expect(response.status).to eq 302
    end      
  end
end