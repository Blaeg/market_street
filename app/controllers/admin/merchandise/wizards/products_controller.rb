class Admin::Merchandise::Wizards::ProductsController < Admin::Merchandise::Wizards::BaseController
  def new
    if f = next_wizard_form
      redirect_to f
    else
      form_info
      @product = Product.new
      @product.brand_id         = session[:product_wizard][:brand_id]
      @product.product_type_id  = session[:product_wizard][:product_type_id]      
    end
  end

  def create
    @product = Product.new(allowed_params)
    if @product.save
      reset_product_wizard
      flash[:notice] = "Successfully created product."
      redirect_to edit_admin_merchandise_products_description_url(@product)
    else
      form_info
      render :action => 'new'
    end
  end

  private

  def allowed_params
    params.require(:product).permit(:name, :description, :product_keywords, :set_keywords, :product_type_id, :prototype_id, :permalink, :available_at, :deleted_at, :meta_keywords, :meta_description, :featured, :description_markup, :brand_id)
  end

  def form_info
    if session[:product_wizard][:prototype_id]
      @all_properties           = Prototype.find(session[:product_wizard][:prototype_id]).properties
    else #@all_properties           = Property.all
      @all_properties           = Property.find(session[:product_wizard][:property_ids])
    end
    @select_product_types     = ProductType.all.collect{|pt| [pt.name, pt.id]}
    @brands        = Brand.order(:name).collect {|ts| [ts.name, ts.id]}
  end
end
