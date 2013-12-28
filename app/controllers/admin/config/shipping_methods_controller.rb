class Admin::Config::ShippingMethodsController < Admin::Config::BaseController
  add_breadcrumb "Shipping Methods", :admin_config_shipping_methods_path
  
  def index
    @shipping_methods = ShippingMethod.all
  end

  # GET /admin/config/shipping_methods/new
  def new
    @shipping_method = ShippingMethod.new    
  end

  # GET /admin/config/shipping_methods/1/edit
  def edit
    @shipping_method = ShippingMethod.find(params[:id])    
  end

  # POST /admin/config/shipping_methods
  def create
    @shipping_method = ShippingMethod.new(allowed_params)
    
    if @shipping_method.save
      redirect_to(admin_config_shipping_methods_url, :notice => 'Shipping method was successfully created.')
    else      
      render :action => "new"
    end
  end

  # PUT /admin/config/shipping_methods/1
  def update
    @shipping_method = ShippingMethod.find(params[:id])
    if @shipping_method.update_attributes(allowed_params)
      redirect_to(admin_config_shipping_methods_url, :notice => 'Shipping method was successfully updated.')
    else
      render :action => "edit"
    end
  end

  private

  def allowed_params
    params.require(:shipping_method).permit(:name)
  end  
end
