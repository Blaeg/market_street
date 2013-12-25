class Customer::BaseController < ApplicationController
  helper_method :selected_customer_tab
  before_filter :require_user
  before_filter :expire_all_browser_cache

  protected
  
  def ssl_required?
    ssl_supported?
  end

  def selected_customer_tab(tab)
    tab == ''
  end
end
