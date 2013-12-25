class Admin::BaseController < ApplicationController
  add_breadcrumb "Admin", :admin_overviews_path
  helper_method :recent_admin_users
  layout 'admin'
  before_filter :verify_admin

  private

  def recent_admin_users
    session[:recent_users] ||= []
  end

  def add_to_recent_user(user)
    session[:recent_users] ||= []
    if session[:recent_users].any?{|email, id| id == user.id }
      session[:recent_users].delete_if {|email, id| id == user.id}
    elsif session[:recent_users].size > 10
      session[:recent_users].pop
    end
    session[:recent_users].unshift( [user.email, user.id] )
  end


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
