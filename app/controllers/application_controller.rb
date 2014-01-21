class ApplicationController < ActionController::Base
  add_breadcrumb "Home", :root_path
  protect_from_forgery
  layout :themed_layout
  
  helper_method :current_user,
                :session_cart,
                :search_product,
                :product_types,
                :customer_confirmation_page_view,
                :sort_column, 
                :sort_direction

  before_filter :secure_session

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    flash[:alert] = 'Sorry you are not allowed to do that.'
    
    if current_user && current_user.admin?
      redirect_to :back
    else
      redirect_to root_url
    end
  end

  rescue_from ActiveRecord::DeleteRestrictionError do |exception|
    redirect_to :back, alert: exception.message
  end

  def product_types
    @product_types ||= ProductType.roots
  end

  def themed_layout
    'application'
    'themes/cyborg'
  end

  private

  def customer_confirmation_page_view
    false
  end

  def pagination_page
    params[:page] ||= 1
    params[:page].to_i
  end

  def pagination_rows
    params[:rows] ||= 25
    params[:rows].to_i
  end

  def sort_column
    params[:sort] ? params[:sort] : self.default_sort_column
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def require_user
    redirect_to login_url and store_return_location and return unless current_user
  end

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

  def store_return_location
    # disallow return to login, logout, signup pages
    disallowed_urls = [ login_url, logout_url ]
    disallowed_urls.map!{|url| url[/\/\w+$/]}
    unless disallowed_urls.include?(request.url)
      session[:return_to] = request.url
    end
  end

  def search_product
    @search_product || Product.new
  end

  def secure_session
    if Rails.env == 'production' and session_cart and !request.ssl?
      cookies[:insecure] = true      
    end
    cookies[:insecure] = false    
  end

  def session_cart
    return @session_cart if defined?(@session_cart)    
    return current_user.current_cart if current_user && current_user.current_cart
    Cart.create      
  end

  ###  Authlogic helper methods
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def cc_params
    {
          :brand              => params[:type],
          :number             => params[:number],
          :verification_value => params[:verification_value],
          :month              => params[:month],
          :year               => params[:year],
          :first_name         => params[:first_name],
          :last_name          => params[:last_name]
    }
  end

  def expire_all_browser_cache
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
