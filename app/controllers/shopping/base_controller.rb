class Shopping::BaseController < ApplicationController
  helper_method :current_line, :current_order
  before_filter :require_user
  
  protected

  private

  def next_form_url(order)
    next_form(order) || shopping_orders_path
  end

  def next_form(order)
    if session_cart.cart_items.empty? # if cart is empty
      flash[:notice] = I18n.t('do_not_have_anything_in_your_cart')
      return catalog_products_url
    
    elsif not_secure? ## If we are insecure
      session[:return_to] = shopping_orders_url
      return login_url()
    elsif session_order.ship_address_id.nil?
      return shopping_addresses_url()
    end
  end

  def not_secure?
    !current_user || has_not_logged_in_recently? || user_visited_a_non_ssl_page_since_login?
  end

  def has_not_logged_in_recently?(minutes = 20)
    session[:authenticated_at].nil? || Time.now - session[:authenticated_at] > (60 * minutes)
  end

  ## this should happen every time the user goes to a non-SSL page
  def user_visited_a_non_ssl_page_since_login?
    cookies[:insecure].nil? || cookies[:insecure] == true
  end  
end
