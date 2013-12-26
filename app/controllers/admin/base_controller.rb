class Admin::BaseController < ApplicationController
  add_breadcrumb "Admin", :admin_overviews_path
  layout 'admin'
  before_filter :verify_admin

  private
  
  def ssl_required?
    ssl_supported?
  end

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
