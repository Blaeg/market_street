class Admin::Merchandise::ProductTypesController < Admin::BaseController
  add_breadcrumb "Product Types", :admin_merchandise_product_types_path
  helper_method :sort_column, :sort_direction
  respond_to :html, :json
  def index
    @q = ProductType.search(params[:q])
    @product_types = @q.result.page(params[:page]).
    order(sort_column + " " + sort_direction).
    page(pagination_page).per(pagination_rows)    
  end

  def show
    @product_type = ProductType.find(params[:id])
    respond_with(@product_type)
  end

  def new
    @product_type = ProductType.new
    form_info
  end

  def create
    @product_type = ProductType.new(allowed_params)

    if @product_type.save
      redirect_to :action => :index
    else
      form_info
      flash[:error] = "The product_type could not be saved"
      render :action => :new
    end
  end

  def edit
    @product_type = ProductType.find(params[:id])
    form_info
  end

  def update
    @product_type = ProductType.find(params[:id])

    if @product_type.update_attributes(allowed_params)
      redirect_to :action => :index
    else
      form_info
      render :action => :edit
    end
  end

  def destroy
    @product_type = ProductType.find(params[:id])
    @product_type.active = false
    @product_type.save

    redirect_to :action => :index
  end

  def default_sort_column
    "product_types.name"
  end  
  
  private

  def allowed_params
    params.require(:product_type).permit( :name, :parent_id )
  end

  def form_info
    @product_types = ProductType.all
  end
end