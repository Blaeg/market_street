class Admin::OnboardController < Admin::BaseController
  skip_before_filter :verify_admin
  before_filter :require_user, :make_super_admin

  def index
    add_breadcrumb "On Board", :admin_onboard_path      
  end

  private
  
  def make_super_admin
    if User::super_admin.empty?
      current_user.role_ids = Role.all.map{|r| r.id }
      current_user.save       
    end
  end
end
