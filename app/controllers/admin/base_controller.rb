class Admin::BaseController < ApplicationController
  add_breadcrumb "Admin", :admin_dashboard_path
  layout 'admin'
  
  before_filter :verify_admin  
end
