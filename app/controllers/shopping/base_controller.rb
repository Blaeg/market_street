class Shopping::BaseController < ApplicationController
  helper_method :session_order, :session_order_id
  helper_method :current_line, :current_order

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

  def session_order
    find_or_create_order
  end

  def session_order_id
    session[:order_id] ? session[:order_id] : find_or_create_order.id
  end

  def find_or_create_order
    return @session_order if @session_order
    if session[:order_id].nil?
      create_order
    else
      @session_order = current_user.orders.include_checkout_objects.find(session[:order_id])
      create_order unless @session_order.initial?
    end
    @session_order
  end

  def create_order
    @session_order = current_user.orders.create(:number       => Time.now.to_i,
                                                :ip_address   => request.env['REMOTE_ADDR'],
                                                :bill_address => current_user.bill_address  )
    add_new_cart_items(session_cart.cart_items)
    session[:order_id] = @session_order.id
  end

  def add_new_cart_items(items)
    items.each do |item|
      @session_order.add_items(item.variant, item.quantity)
    end
  end  
end
