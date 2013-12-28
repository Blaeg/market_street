require 'spec_helper'

describe Admin::OnboardController do
  render_views
  
  before(:each) do
    activate_authlogic    
  end

  context "not logged in" do 
    it "redirects to root url" do 
      get :index
      expect(response).to redirect_to login_url      
    end
  end

  context "logged in as regular a user" do 
    let(:user) { create(:user) }
    it "make the user super admin" do 
      login_as(user)
      get :index
      expect(response).to be_success
      expect(user).to be_admin
      expect(user).to be_super_admin
    end
  end

  context "logged in as admin user" do 
    let(:admin_user) { create(:admin_user) }    
    it "redirects to root url" do 
      login_as(admin_user)
      get :index
      expect(response).to be_success
      expect(admin_user).to be_admin
      expect(admin_user).to be_super_admin
    end
  end

  context "logged in as super admin user" do 
    let(:super_admin_user) { create(:super_admin_user) }
    it "redirects to root url" do 
      login_as(super_admin_user)
      get :index
      expect(response).to be_success
      expect(super_admin_user).to be_admin
      expect(super_admin_user).to be_super_admin
    end
  end
end
