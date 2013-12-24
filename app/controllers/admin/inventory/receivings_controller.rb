class Admin::Inventory::ReceivingsController < Admin::BaseController
  add_breadcrumb "Purchase Orders to be Received", :admin_inventory_receivings_path
  helper_method :sort_column, :sort_direction

  def index
    @q = PurchaseOrder.search(params[:q])
    @purchase_orders = @q.result.order(sort_column + " " + sort_direction).
                              page(pagination_page).per(pagination_rows)
  end

  def edit
    @purchase_order = PurchaseOrder.includes([:variants ,
                                              :supplier,
                                              {:purchase_order_variants => {:variant => :product }}]).find(params[:id])
  end

  def update
    @purchase_order = PurchaseOrder.find(params[:id])

    if @purchase_order.update_attributes(allowed_params)
      redirect_to(:action => :index, :notice => 'Purchase order was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def default_sort_column
    "purchase_orders.id"
  end  
  
  private

  def allowed_params
    params.require(:purchase_order).permit(:invoice_number, :tracking_number, :notes, :receive_po)
  end 
end
