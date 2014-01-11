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

  it "index action renders index template" do
    get :index
    expect(response).to render_template(:index)
  end

  it "create action redirects when model is valid" do
    Address.any_instance.stubs(:valid?).returns(true)
    post :create, :address => ship_address.attributes
    expect(response).to redirect_to(shopping_checkout_path)
  end

  it "edit action renders edit template" do
    get :edit, :id => ship_address.id
    expect(response).to render_template(:edit)
  end

  it "update action redirects when model is valid" do
    Address.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ship_address.id, :address => ship_address.attributes
    expect(response).to redirect_to(shopping_checkout_path)
  end

  it "update action redirects when model is valid" do
    Address.any_instance.stubs(:valid?).returns(true)
    put :select_address, :id => ship_address.id
    expect(response).to redirect_to(shopping_checkout_path)
  end

  context "invalid address" do 
    it "redirects to index template" do
      ship_address.id = nil
      post :create, :address => ship_address.attributes
      expect(response).to render_template(:index)
    end
    
    it "redirects to edit template" do
      ship_address.first_name = nil #invalidate the address
      put :update, :id => ship_address.id, :address => ship_address.attributes
      expect(response).to render_template(:edit)
    end
  end
end
