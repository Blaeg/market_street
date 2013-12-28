class Admin::Fulfillment::OrdersController < Admin::Fulfillment::BaseController
  add_breadcrumb "Orders", :admin_fulfillment_orders_path
  
  def index
    @q = Order.search(params[:q])
    @orders = @q.result.where("orders.completed_at IS NOT NULL").
                order(sort_column + " " + sort_direction).
                page(pagination_page).per(pagination_rows)
  end

  # GET /admin/fulfillment/orders/1
  def show
    @order = Order.includes([:user, :shipments, 
                        {:order_items => [:shipment, :variant]}]).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /admin/fulfillment/orders/1/edit
  def edit
    @order = Order.includes([:user, :shipments, {:order_items => [:shipment, :variant]}]).find(params[:id])    
  end


  def create_shipment
    @order = Order.find_by_id(params[:id])
    if @order
      Shipment.create_shipments_with_items(@order)
      @order.reload
    end
  end

  # PUT /admin/fulfillment/orders/1
  def update
    @order    = Order.find_by_id(params[:id])
    @invoice  = @order.invoices.find(params[:invoice_id])

    payment = @order.capture_invoice(@invoice)

    ##  several things happen on this request
    # => Payment is captured
    # => Invoice is updated to log leger transactions
    # => Shipment is marked as ready to send and associated to the order_items
    # => If everything works send the user to the shipment page


    ## TODO
    # => Allow partial payments
    # => mark only order_items that will be shipped

    if payment && payment.success?
      render :partial => 'success_message'
    else
      render :partial => 'failure_message'
    end
  end

  protected

  def default_sort_column
    "number"
  end
end
