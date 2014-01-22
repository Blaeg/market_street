require 'spec_helper'

describe Customer::ActivationsController do
  render_views
  let(:user) { create(:user, :state => 'inactive') }
  
  it "show action renders show template" do
    get :show, :id => user.id, :a => user.perishable_token
    expect(assigns[:user].id).to eq user.id
    expect(response).to redirect_to(root_url)
  end

  it "show action renders show template" do
    get :show, :id => user.id, :a => 'bad0perishabletoken'
    expect(assigns[:user]).to be_nil
    expect(response).to redirect_to(root_url)
  end
end
