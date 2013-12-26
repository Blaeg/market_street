class Admin::ReportsController < Admin::BaseController
  helper_method :start_time, :end_time
  before_filter :set_start_time
  before_filter :set_end_time

  def dashboard
    @accounting_report  = ::Reports::Accounting.new(start_time, end_time)
    @orders_report      = ::Reports::Orders.new(start_time, end_time)
    @customers_report   = ::Reports::Customers.new(start_time, end_time)
    @final_number_of_cart_items     = CartItem.before(end_time).last   ? CartItem.before(end_time).last.id   : 0
    @beginning_number_of_cart_items = CartItem.before(start_time).last ? CartItem.before(start_time).last.id : 0
  end

  def set_start_time
    @start_time = Chronic.parse('last week').beginning_of_week
    @start_time = Time.parse(params[:start_date]) if params[:start_date].present?    
  end

  def set_end_time
    @end_time = case params[:commit]
    when 'Daily'
      start_time + 1.day
    when 'Weekly'
      start_time + 1.week
    when 'Monthly'
      start_time + 1.month
    else
      start_time + 1.week
    end
  end

  def start_time
    @start_time
  end

  def end_time
    @end_time
  end
end
