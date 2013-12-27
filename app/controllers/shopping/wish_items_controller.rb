class Shopping::WishItemsController < ApplicationController
  add_breadcrumb "Wish List", :shopping_wish_items_path
  before_filter :require_user

  def index
    @wish_items = current_user.wish_items
  end

  #json only
  def create
    @wish_item = WishItem.new(allowed_params)
    if current_user.wish_items << @wish_item
      respond_to do |format|
        format.json { render json: @wish_item.to_json}
      end
    end
  end

  def destroy
    if params[:id]
      item = current_user.wish_items(params[:id]).first
      item.destroy
    end

    respond_to do |format|
      format.json { render json: {status: :ok} }
    end        
  end

  protected

  def allowed_params
    params.permit(:user_id, :variant_id)
  end
end
