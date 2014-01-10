class Customer::OrdersController < Customer::BaseController
  # GET /customer/orders
  # GET /customer/orders.xml
  def index
    @orders = current_user.finished_orders.find_customer_details
  end

  # GET /customer/orders/1
  # GET /customer/orders/1.xml
  def show
    @order = current_user.finished_orders.includes([:invoices])
                        .find_by_number(params[:id])
  end

  private

  def selected_customer_tab(tab)
    tab == 'orders'
  end
end
