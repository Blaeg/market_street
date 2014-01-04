class Shopping::CartItemsController < Shopping::BaseController
  def create
    session_cart.save if session_cart.new_record?    
    if cart_item = session_cart.add_variant(variant.id, new_quantity)
      session_cart.save_user(current_user)
      redirect_to shopping_cart_url
    else #error case          
      redirect_to product_url(variant.product)
    end    
  end

  # PUT /shopping/cart_items
  def update    
    if new_quantity == 0
      cart_item.destroy
      render json: {:message => I18n.t('item_passed_update')}, status: :ok
    elsif cart_item.update_attributes(allowed_params)
      render json: {:message => I18n.t('item_passed_update')}, status: :ok
    else
      render json: {:message => I18n.t('item_failed_update')}, status: :error
    end
  end

  private

  def allowed_params
    params.require(:cart_item).permit(:quantity, :variant_id)
  end

  def cart_item
    @cart_item ||= CartItem.find(params[:id])
  end

  def variant
    @variant ||= Variant.find_by_id(allowed_params[:variant_id])    
  end

  def new_quantity 
    @new_quantity ||= allowed_params[:quantity].to_i    
  end  
end
