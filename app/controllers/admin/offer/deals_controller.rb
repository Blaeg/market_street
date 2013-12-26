class Admin::Offer::DealsController < Admin::Offer::BaseController
  add_breadcrumb "Deals", admin_offer_coupons_path
  helper_method :product_types,:deal_types

  def index
    @deals = Deal.order(sort_column + " " + sort_direction).
              page(pagination_page).per(pagination_rows)
  end

  def show
    @deal = Deal.find(params[:id])
  end

  def new
    @deal = Deal.new
  end

  def create
    @deal = Deal.new(allowed_params)
    if @deal.save
      redirect_to [:admin, :offer, @deal], :notice => "Successfully created deal."
    else
      render :new
    end
  end

  def edit
    @deal = Deal.find(params[:id])
  end

  def update
    @deal = Deal.find(params[:id])
    if @deal.update_attributes(allowed_params)
      redirect_to [:admin, :offer, @deal], :notice  => "Successfully updated deal."
    else
      render :edit
    end
  end

  def destroy
    @deal = Deal.find(params[:id])
    @deal.deleted_at = Time.zone.now
    @deal.save
    redirect_to admin_offer_deals_url, :notice => "Successfully deleted deal."
  end

  def default_sort_column
    "deals.buy_quantity"
  end    

  private

  def allowed_params
    params.require(:deal).permit(:buy_quantity, :get_percentage, :deal_type, :product_type_id, :get_amount, :deleted_at)
  end

  def product_types
    @select_product_types     ||= ProductType.all.collect{|pt| [pt.name, pt.id]}
  end    
end
