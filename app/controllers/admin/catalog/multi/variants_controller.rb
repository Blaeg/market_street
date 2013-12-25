class Admin::Catalog::Multi::VariantsController < Admin::BaseController
  def edit
    @product = Product.find(params[:product_id])        
  end

  def update
    @product = Product.find(params[:product_id])
    if @product.update_attributes(allowed_params)
      flash[:notice] = "Successfully updated variants"
      redirect_to admin_catalog_product_url(@product)
    else
      render :action => :edit
    end
  end

  private

  def allowed_params
    params.require(:product).permit!
  end  
end
