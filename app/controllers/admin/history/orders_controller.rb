class Admin::History::OrdersController < Admin::BaseController
  # GET /admin/history/orders
  def index
    @orders = Order.find_finished_order_grid(params).
                page(pagination_page).per(pagination_rows)
  end

  # GET /admin/history/orders/1
  def show
    @order = Order.includes([:ship_address, :invoices,
                             {:shipments => :shipping_method},
                             {:order_items => [
                                                {:variant => [:product, :variant_properties]}]
                              }]).find_by_number(params[:id])
  end

end
