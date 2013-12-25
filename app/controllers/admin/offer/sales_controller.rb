# Use this model to create 20% off sales for any given product

class Admin::Offer::SalesController < Admin::Offer::BaseController
  helper_method :sort_column, :sort_direction, :products
  def index
    @sales = Sale.order(sort_column + " " + sort_direction).
              page(pagination_page).per(pagination_rows)
  end

  def show
    @sale = Sale.find(params[:id])
  end

  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(allowed_params)
    if @sale.save
      redirect_to [:admin, :offer, @sale], :notice => "Successfully created sale."
    else
      render :new
    end
  end

  def edit
    @sale = Sale.find(params[:id])
  end

  def update
    @sale = Sale.find(params[:id])
    if @sale.update_attributes(allowed_params)
      redirect_to [:admin, :offer, @sale], :notice  => "Successfully updated sale."
    else
      render :edit
    end
  end

  def destroy
    @sale = Sale.find(params[:id])
    @sale.destroy
    redirect_to admin_offer_sales_url, :notice => "Successfully destroyed sale."
  end

  def default_sort_column
    "sales.product_id"
  end    

  private

  def allowed_params
    params.require(:sale).permit(:product_id, :percent_off, :starts_at, :ends_at)
  end

  def products
    @products ||= Product.select([:id, :name]).map{|p| [p.name, p.id]}
  end
end