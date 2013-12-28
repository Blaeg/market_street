class Admin::Fulfillment::OrderAddressesController < Admin::BaseController
  add_breadcrumb "Shipping Address", :admin_fulfillment_order_addresses_path
  before_filter :order
  helper_method :states
  
  def index
    @addresses = @order.user.addresses
  end

  def show
    @address = Address.find(params[:id])
  end

  def new
    add_breadcrumb "New Address", :new_admin_fulfillment_order_address_path  
    @address  = Address.new
  end

  def edit
    add_breadcrumb "Change Address", :edit_admin_fulfillment_order_address_path   
    @address  = Address.find(params[:id])
  end

  def create 
    @address  = @order.user.addresses.new(allowed_params)

    respond_to do |format|
      if @address.save
        @order.ship_address = @address
        @order.save
        format.html { redirect_to(admin_fulfillment_order_path(@order), :notice => 'Address was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @address  = Address.find(params[:id])

    respond_to do |format|
      if @address && @order.ship_address = @address
        if @order.save
          format.html { redirect_to(admin_fulfillment_order_path(@order) , :notice => 'Address was successfully selected.') }
        else
          format.html { render :action => "edit" }
        end
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def order
    @order = Order.includes({:user => :addresses}).find_by_number(params[:order_id])    
  end

  private

  def allowed_params
    params.require(:address).permit(:address_type, :first_name, 
      :last_name, :address1, :address2, :city, :state_id, :state_name, :zip_code, 
      :phone_id, :alternative_phone, :default, :billing_default, :active, :country_id)
  end

  def states
    @states ||= State.form_selector
  end
end
