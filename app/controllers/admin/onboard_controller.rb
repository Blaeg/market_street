class Admin::OnboardController < Admin::BaseController
  layout "admin"
  before_filter :verify_admin, :make_first_user_super_admin

  def index
    add_breadcrumb "On Board", :admin_onboard_path  
  end

  private
  
  def session_args
    @session_args ||= { :email => @user.email, :password => @password }
  end  

  def make_first_user_super_admin
    if current_user == User.first and not current_user.super_admin?
      current_user.role_ids = Role.all.map{|r| r.id }
      current_user.save        
    end
  end
end
