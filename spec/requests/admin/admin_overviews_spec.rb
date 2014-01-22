require 'spec_helper'

def cookied_admin_login
   User.acts_as_authentic_config[:maintain_sessions] = false
   u = create_real_admin_user({:email => 'test@admin.com', :password => 'secret1', :password_confirmation => 'secret1'})

   u.id.should_not be_nil
   visit login_path
   within("#login") do
     fill_in 'Email',    :with => 'test@admin.com'
     fill_in 'Password', :with => 'secret1'
     click_button 'Sign In'
   end
end

def cookied_login
   User.acts_as_authentic_config[:maintain_sessions] = false
   create(:user, :first_name => 'Alex', :email => 'test@nonadmin.com', 
      :password => 'secret1', :password_confirmation => 'secret1')

   User.any_instance.stubs(:admin?).returns(false)
   visit login_path
   within("#login") do
     fill_in 'Email',    :with => 'test@nonadmin.com'
     fill_in 'Password', :with => 'secret1'
     click_button 'Sign In'
   end
end

describe "Admin::Onboard" do
  describe "GET /admin/onboard" do
    it "works!" do
      cookied_login
      User.any_instance.stubs(:activate!).returns(true)
      visit admin_onboard_path
      expect(User.first).not_to be_nil      
    end
  end
end

describe "Admin::Onboard" do
  describe "GET /admin/onboard" do
    it "If a user has already been created this page will show without password info for admin users" do
      cookied_admin_login
      visit admin_onboard_path
      page.should have_content('Market Street')
    end
  end
end
describe "Admin::Onboard" do

  describe "GET /admin/onboard" do
    it "If a user has already been created this page will redirect to root_url for non-admins" do
      cookied_login
      visit admin_onboard_path
      page.should have_content('Welcome')
      page.should have_content('Market Street')
    end
  end
end
