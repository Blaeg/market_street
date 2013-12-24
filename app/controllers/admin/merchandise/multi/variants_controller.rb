class Admin::Merchandise::Multi::VariantsController < Admin::BaseController
  helper_method :image_groups
  def edit
    @product = Product.find(params[:product_id])        
  end

  def update
    @product = Product.find(params[:product_id])
    if @product.update_attributes(allowed_params)
      flash[:notice] = "Successfully updated variants"
      redirect_to admin_merchandise_product_url(@product)
    else
      render :action => :edit
    end
  end

  private

  def allowed_params
    params.require(:product).permit!
  end

  def image_groups
    @image_groups ||= ImageGroup.where(:product_id => @product).map{|i| [i.name, i.id]}
  end  
end
