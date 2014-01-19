class Shopping::BillingAddressesController < Shopping::BaseController
  helper_method :countries, :phone_types
  # GET /shopping/addresses
  def index
    if session_cart.cart_items.empty?
      flash[:notice] = I18n.t('do_not_have_anything_in_your_cart')
      return redirect_to catalog_products_url
    end
  
    @form_address = @shopping_address = Address.new
    
    if !Settings.require_state_in_address && countries.size == 1
      @shopping_address.country = countries.first
    end
    form_info
  end

  def edit
    form_info
    @form_address = @shopping_address = Address.find(params[:id])
  end

  # POST /shopping/addresses
  def create
    @shopping_address = current_user.addresses.new(allowed_params)
    @shopping_address.ship_default = (current_user.default_shipping_address.nil?)
    @shopping_address.bill_default = (current_user.default_billing_address.nil?)
    @shopping_address.save
    @form_address = @shopping_address
  
    if @shopping_address.id
      redirect_to(next_form_url(session_order))
    else
      form_info
      render :action => "index"
    end
  end

  def update
    @shopping_address = current_user.addresses.new(allowed_params)
    # This makes the address we are updating inactive if we save successfully
    @shopping_address.replace_address_id = params[:id] 
    @shopping_address.ship_default = (params[:id].to_i == current_user.default_shipping_address.try(:id))
    @shopping_address.bill_default = (params[:id].to_i == current_user.default_billing_address.try(:id))

    if @shopping_address.save
      redirect_to(next_form_url(session_order))
    else
      # the form needs to have an id
      @form_address = current_user.addresses.find(params[:id])
      # the form needs to reflect the attributes to customer entered
      @form_address.attributes = allowed_params
      @states     = State.form_selector
      render action: "edit"
    end
  end

  def select_address
    address = current_user.addresses.find(params[:id])
    redirect_to next_form_url(session_order)
  end

  def destroy
    @shopping_address = Address.find(params[:id])
    @shopping_address.update_attributes(active: false)

    redirect_to(shopping_billing_addresses_url)
  end

  private

  def selected_checkout_tab(tab)
    tab == 'billing-address'
  end

  def allowed_params
    params.require(:address).permit(:first_name, :last_name, 
      :address1, :address2, :city, :state_id, :state_name, 
      :zip_code, :default, :bill_default, :country_id)
  end

  def phone_types
    @phone_types ||= PhoneType.all.map{|p| [p.name, p.id]}
  end

  def form_info
    @shopping_addresses = current_user.shipping_addresses
    @states     = State.form_selector
  end
end