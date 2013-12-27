class Admin::History::OrdersController < Admin::BaseController
  add_breadcrumb "Order History", :admin_history_orders_path
    
  def index
    @q = Order.search(params[:q])
    @orders = @q.result.where("orders.completed_at IS NOT NULL").
                order(sort_column + " " + sort_direction).
                page(pagination_page).per(pagination_rows)          
  end

  def show
    @order = Order.includes([:ship_address, :invoices,
                             {:shipments => :shipping_method},
                             {:order_items => [ {:variant => [:product, :variant_properties]}]
                              }]).find_by_number(params[:id])
  end

  def default_sort_column
    "number"
  end
end
