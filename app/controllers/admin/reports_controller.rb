class Admin::ReportsController < Admin::BaseController
  helper_method :start_date, :end_date, :display_start_and_end_date
  before_filter :set_start_date, :set_end_date
  
  def dashboard
    add_breadcrumb "Dashboard", :admin_dashboard_path
    
    @accounting_report = ::Reports::Accounting.new(start_date, end_date)
    @orders_report = ::Reports::Orders.new(start_date, end_date)
    @customers_report = ::Reports::Customers.new(start_date, end_date)
    
    @final_number_of_cart_items = CartItem.before(end_date).last   ? CartItem.before(end_date).last.id : 0    
    @beginning_number_of_cart_items = CartItem.before(start_date).last ? CartItem.before(start_date).last.id : 0
  end

  private
  
  def set_start_date
    if params[:start_date].present?    
      @start_date = Time.parse(params[:start_date]).beginning_of_day.to_date
    else
      @start_date = Chronic.parse('last week').beginning_of_week.to_date
    end    
  end

  def set_end_date
    @end_date = case params[:commit]
      when 'Daily'
        start_date + 1.day
      when 'Weekly'
        start_date + 1.week
      when 'Monthly'
        start_date + 1.month
      else
        start_date + 1.week
      end
  end

  def start_date
    @start_date
  end

  def end_date
    @end_date
  end

  def display_start_and_end_date
    "#{I18n.localize(start_date)}-#{I18n.localize(end_date)}"
  end
end
