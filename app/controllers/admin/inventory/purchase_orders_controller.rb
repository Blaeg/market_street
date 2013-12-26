class Admin::Inventory::PurchaseOrdersController < Admin::BaseController
  add_breadcrumb "Purchase Order", :admin_inventory_purchase_orders_path
  
  def index
    @q = PurchaseOrder.search(params[:q])
    @purchase_orders = @q.result.order(sort_column + " " + sort_direction).
                          page(pagination_page).per(pagination_rows)

  end

  # GET /purchase_orders/1
  def show
    @purchase_order = PurchaseOrder.find(params[:id])
  end

  # GET /purchase_orders/new
  def new
    @purchase_order = PurchaseOrder.new
    form_info
    if @select_suppliers.empty?
      flash[:notice] = 'You need to have a supplier before you can create a purchase order.'
      redirect_to new_admin_inventory_supplier_url
    end
  end

  # GET /purchase_orders/1/edit
  def edit
    @purchase_order = PurchaseOrder.find(params[:id])
    form_info
  end

  # POST /purchase_orders
  def create
    @purchase_order = PurchaseOrder.new(allowed_params)

    if @purchase_order.save
      redirect_to(:action => :index, :notice => 'Purchase order was successfully created.')
    else
      form_info
      render :action => "new"
    end
  end

  # PUT /purchase_orders/1
  def update
    @purchase_order = PurchaseOrder.find(params[:id])
    if @purchase_order.update_attributes(allowed_params)
      redirect_to(:action => :index, :notice => 'Purchase order was successfully updated.')
    else
      form_info
      render :action => "edit"
    end
  end

  # DELETE /purchase_orders/1
  def destroy
    @purchase_order = PurchaseOrder.find(params[:id])
    @purchase_order.destroy
    redirect_to(admin_inventory_purchase_orders_url)
  end
  
  def default_sort_column
    "purchase_orders.id"
  end  

  private

  def allowed_params
    params.require(:purchase_order).permit(:supplier_id, :invoice_number, :tracking_number, :notes, :receive_po, :ordered_at, :estimated_arrival_on, :created_at, :updated_at, :total_cost)
  end

  def form_info
    @select_suppliers = Supplier.all.collect{|s| [s.name, s.id]}
    @select_variants  = Variant.includes(:product).collect {|v| [v.name_with_sku, v.id]}
  end  
end
