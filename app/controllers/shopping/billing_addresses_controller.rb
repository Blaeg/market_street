class Shopping::BillingAddressesController < Shopping::BaseController
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
      render json: {}, status: :ok
    else
      form_info
      redirect_to(shopping_cart_review_path, :notice => 'Address was not created.')
    end
  end

  def update
    @shopping_address = current_user.addresses.new(allowed_params)
    # This makes the address we are updating inactive if we save successfully
    @shopping_address.replace_address_id = params[:id] 
    @shopping_address.ship_default = (params[:id].to_i == current_user.default_shipping_address.try(:id))
    @shopping_address.bill_default = (params[:id].to_i == current_user.default_billing_address.try(:id))

    if @shopping_address.save
      render json: {}, status: :ok
    else
      # the form needs to have an id
      @form_address = current_user.addresses.find(params[:id])
      # the form needs to reflect the attributes to customer entered
      @form_address.attributes = allowed_params
      @states     = State.form_selector
      redirect_to(shopping_cart_review_path, :notice => 'Address was not updated.')
    end
  end

  def destroy
    @shopping_address = Address.find(params[:id])
    @shopping_address.update_attributes(active: false)
    head :ok    
  end

  private

  def selected_checkout_tab(tab)
    tab == 'billing-address'
  end

  def allowed_params
    params.require(:address).permit(:first_name, :last_name, 
      :address1, :address2, :city, :state_id, :state_name, 
      :zip_code, :default, :bill_default, :country_code)
  end

  def form_info
    @shopping_addresses = current_user.shipping_addresses
    @states     = State.form_selector
  end
end