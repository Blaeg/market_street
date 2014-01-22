require 'spec_helper'

describe Customer::ActivationsController do
  render_views

  it "show action renders show template" do
    @user = create(:user, :state => 'inactive')
    get :show, :id => @user.id, :a => @user.perishable_token
    assigns[:user].id.should == @user.id
    expect(response).to redirect_to(root_url)
  end

  it "show action renders show template" do
    @user = create(:user, :state => 'inactive')
    get :show, :id => @user.id, :a => 'bad0perishabletoken'
    assigns[:user].should == nil
    expect(response).to redirect_to(root_url)
  end
end
