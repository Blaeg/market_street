class Admin::Inventory::SuppliersController < Admin::BaseController
  add_breadcrumb "Suppliers", :admin_inventory_suppliers_path
  helper_method :sort_column, :sort_direction
  respond_to :json, :html

  def index
    @q = Supplier.search(params[:q])
    @suppliers = @q.result.order(sort_column + " " + sort_direction).
    page(pagination_page).per(pagination_rows)    
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(allowed_params)

    if @supplier.save
      redirect_to :action => :index
    else
      flash[:error] = "The supplier could not be saved"
      render :action => :new
    end
  end

  def edit
    @supplier = Supplier.find(params[:id])
  end

  def update
    @supplier = Supplier.find(params[:id])
    if @supplier.update_attributes(allowed_params)
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end

  def show
    @supplier = Supplier.find(params[:id])
    respond_with(@supplier)
  end

  def default_sort_column
    "suppliers.id"
  end

  private

  def allowed_params
    params.require(:supplier).permit(:name, :email)
  end
end