class Admin::BaseController < ApplicationController
  add_breadcrumb "Admin", :admin_overviews_path
  before_filter :verify_admin
  helper_method :sort_column, :sort_direction
  layout 'admin'
  
  private

  #move to cancan
  def verify_admin
    redirect_to root_url if !current_user || !current_user.admin?
  end

  def verify_super_admin
    if current_user && current_user.admin? && !current_user.super_admin?
      redirect_to admin_customer_users_url
    elsif !current_user || !current_user.admin?
      redirect_to root_url
    end
  end  
end
