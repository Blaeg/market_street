class Admin::Config::ShippingRatesController < Admin::Config::BaseController
  add_breadcrumb "Shipping Rate", :admin_config_shipping_rates_path
  
  def index
    form_info
    if @shipping_methods.empty?
      flash[:notice] = 'You need a Shipping Method before you create a shipping rate.'
      redirect_to admin_config_shipping_methods_url
    else
      @shipping_rates = ShippingRate.includes(:shipping_method)
    end
  end

  # GET /shipping_rates/1
  def show
    @shipping_rate = ShippingRate.find(params[:id])
  end

  # GET /shipping_rates/new
  def new
    form_info
    if @shipping_methods.empty?
        flash[:notice] = "You must create a Shipping Method before you create a Shipping Rate."
        redirect_to new_admin_config_shipping_method_url
    else
      @shipping_rate = ShippingRate.new
    end
  end

  # GET /shipping_rates/1/edit
  def edit
    @shipping_rate = ShippingRate.find(params[:id])
    form_info
  end

  # POST /shipping_rates
  def create
    @shipping_rate = ShippingRate.new(allowed_params)

    respond_to do |format|
      if @shipping_rate.save
        format.html { redirect_to(admin_config_shipping_rate_url(@shipping_rate), :notice => 'Shipping rate was successfully created.') }
      else
        form_info
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /shipping_rates/1
  def update
    @shipping_rate = ShippingRate.find(params[:id])

    respond_to do |format|
      if @shipping_rate.update_attributes(allowed_params)
        format.html { redirect_to(admin_config_shipping_rate_url(@shipping_rate), :notice => 'Shipping rate was successfully updated.') }
      else
        form_info
        format.html { render :action => "edit" }
      end
    end
  end

  private

  def allowed_params
    params.require(:shipping_rate).permit(:shipping_method_id, :rate, :shipping_rate_type, :minimum_charge, :position, :active)
  end

  def form_info
    @shipping_rate_types  = ShippingRate::SHIPPING_RATE_TYPES.map{|srt| [srt, srt]}
    @shipping_methods     = ShippingMethod.all.map{|sm| [sm.descriptive_name, sm.id]}    
  end
end
