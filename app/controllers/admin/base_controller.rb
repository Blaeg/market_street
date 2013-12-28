class Admin::BaseController < ApplicationController
  add_breadcrumb "Admin", :admin_dashboard_path
  layout 'admin'
  
  before_filter :verify_admin
  helper_method :sort_column, :sort_direction
    
  private

  def verify_admin
    redirect_to root_url unless current_user
    redirect_to admin_onboard_url if current_user and !current_user.admin? 
  end

  def verify_super_admin
    if current_user && current_user.admin? && !current_user.super_admin?
      redirect_to admin_customer_users_url
    elsif !current_user || !current_user.admin?
      redirect_to root_url
    end
  end  
end
