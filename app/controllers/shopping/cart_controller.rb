class Shopping::CartController < Shopping::BaseController
  def current
    @cart_items = session_cart.cart_items    
  end

  def create
    session_cart.save if session_cart.new_record?
    
    qty = params[:cart_item][:quantity].to_i
    if cart_item = session_cart.add_variant(params[:cart_item][:variant_id], qty)
      session_cart.save_user(current_user)
      redirect_to shopping_cart_items_url
    else
      variant = Variant.includes(:product).find_by_id(params[:cart_item][:variant_id])
      if variant
        redirect_to product_url(variant.product)
      else
        flash[:notice] = I18n.t('something_went_wrong')
        redirect_to root_url
      end
    end
  end

  # PUT /shopping/cart_items
  def update
    if session_cart.update_attributes(allowed_params)
      if params[:commit] && params[:commit] == "Checkout"
        redirect_to( checkout_shopping_order_url('checkout'))
      else
        redirect_to(shopping_cart_path, :notice => I18n.t('item_passed_update') )
      end
    else
      redirect_to(shopping_cart_path, :notice => I18n.t('item_failed_update') )
    end
  end

  # id here is actually variant id
  def destroy
    session_cart.remove_variant(params[:id])
    redirect_to(shopping_cart_path)
  end

  private

  def allowed_params
    params.require(:cart).permit!
  end
end
