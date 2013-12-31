class Shopping::ShippingMethodsController < Shopping::BaseController
  before_filter :check_shipping_address, :only => [:index]
  # GET /shopping/shipping_methods
  def index
    session_order.find_sub_total
    @order_items = session_order.order_items
    @order_items.each do |item|
      binding.pry
      shipping_rates = item.variant.product.shipping_method.shipping_rates
      item.variant.product.available_shipping_rates = shipping_rates              
    end
  end

  # PUT /shopping/shipping_methods/1
  def update
    all_selected = true
    redirect_to(shopping_checkout_path) and return unless params[:shipping_category].present?
    params[:shipping_category].each_pair do |rate_id|#[rate]
      if rate_id
        items = OrderItem.includes([{:variant => :product}]).
                          where(['order_items.order_id = ?', session_order_id]).references(:products)

        OrderItem.where(id: items.map{|i| i.id}).update_all("shipping_rate_id = #{rate_id}")
      else
        all_selected = false
      end
    end
    if all_selected
      redirect_to(shopping_checkout_path, :notice => I18n.t('shipping_method_updated'))
    else
      redirect_to( shopping_shipping_methods_url, :notice => I18n.t('all_shipping_methods_must_be_selected'))
    end
  end

  private
  def check_shipping_address
    unless find_or_create_order.ship_address_id
      flash[:notice] = I18n.t('select_address_before_shipping_method')
      redirect_to admin_shopping_checkout_shipping_addresses_url
    end
  end
end