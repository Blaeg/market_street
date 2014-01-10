class Shopping::OrdersController < Shopping::BaseController
  before_filter :require_login
  layout 'light'

  ##### THIS METHOD IS BASICALLY A CHECKOUT ENGINE
  # A)  if there is a current order redirect to the process that
  # => needs to be completed to finish the order process.
  # B)  if the order is ready to be checked out...  give the order summary page.
  def index
    @order = find_or_create_order
    if f = next_form(@order)
      redirect_to f
    else
      expire_all_browser_cache
      form_info
    end
  end

  #  add checkout button
  def checkout
    order = find_or_create_order
    #@order = session_cart.add_items_to_checkout(order) # need here because items can also be removed
    redirect_to next_form_url(order)
  end

  # POST /shopping/orders
  def update
    @order = find_or_create_order
    @order.ip_address = request.remote_ip

    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(cc_params)

    address = @order.bill_address.cc_params

    if !@order.initial?
      flash[:error] = I18n.t('the_order_purchased')
      redirect_to myaccount_order_url(@order)
      return 
    end
    
    if !@credit_card.valid?
      form_info
      flash[:alert] = [I18n.t('credit_card'), I18n.t('is_not_valid')].join(' ')
      render :action => 'index' and return
    end 

    if response = @order.create_invoice(@credit_card, @order.credit_amount,
      { :email => @order.email, 
        :bill_address=> address, 
        :ip=> @order.ip_address }, @order.credit_amount)
      if response.succeeded?
        expire_all_browser_cache
        session[:last_order] = @order.number
        redirect_to( confirmation_shopping_order_url(@order) ) and return
      else
        flash[:alert] =  [I18n.t('could_not_process'), I18n.t('the_order')].join(' ')
      end
    else
      flash[:alert] = [I18n.t('could_not_process'), I18n.t('the_credit_card')].join(' ')
    end

    form_info
    render :action => 'index'    
  end

  def confirmation
    @tab = 'confirmation'
    if session[:last_order].present? && session[:last_order] == params[:id]
      session[:last_order] = nil
      @order = Order.where(:number => params[:id]).includes({:order_items => :variant}).first
      render :layout => 'application'
    else
      session[:last_order] = nil
      if current_user.finished_orders.present?
        redirect_to myaccount_order_url( current_user.finished_orders.last )
      elsif current_user
        redirect_to myaccount_orders_url
      end
    end
  end
  private

  def customer_confirmation_page_view
    @tab && (@tab == 'confirmation')
  end

  def form_info
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new()
    @order.credit_amount
  end
  def require_login
    if !current_user
      session[:return_to] = shopping_checkout_path
      redirect_to( login_url() ) and return
    end
  end

end
