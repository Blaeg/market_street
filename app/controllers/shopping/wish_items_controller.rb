class Shopping::WishItemsController < ApplicationController
  before_filter :require_user

  def index
  end

  # DELETE /wish_items/1
  def destroy
    if params[:id]
      item = current_user.wish_items(params[:id]).first
      item.destroy
    end
    render :action => :index
  end
end
