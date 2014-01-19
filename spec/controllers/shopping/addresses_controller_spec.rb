require 'spec_helper'

describe Shopping::AddressesController do
  render_views

  before(:each) do
    activate_authlogic
    login_as(user)
    create_cart(user, [variant])    
  end

  let(:user) { create(:user) }
  let(:variant) { create(:variant) }
  let(:ship_address) { create(:ship_address, 
    :addressable_id => user.id, :addressable_type => 'User') }

  it "create action redirects when model is valid" do
    Address.any_instance.stubs(:valid?).returns(true)
    post :create, :address => ship_address.attributes
    expect(response).to be_success
  end

  it "edit action renders edit template" do
    get :edit, :id => ship_address.id
    expect(response).to render_template(:edit)
  end

  it "update action redirects when model is valid" do
    Address.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ship_address.id, :address => ship_address.attributes
    expect(response).to be_success
  end

  context "invalid address" do 
    it "redirects to index template" do
      ship_address.first_name = nil
      post :create, :address => ship_address.attributes
      expect(response).to redirect_to shopping_cart_review_path
    end
    
    it "redirects to edit template" do
      ship_address.first_name = nil #invalidate the address
      put :update, :id => ship_address.id, :address => ship_address.attributes
      expect(response).to redirect_to shopping_cart_review_path
    end
  end
end
