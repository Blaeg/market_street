class Admin::Catalog::VariantsController < Admin::BaseController
  add_breadcrumb "Variants", :admin_catalog_product_variants_path
  helper_method :sort_column, :sort_direction
  respond_to :html, :json
  before_filter :current_product

  def index
    @q = Variant.search(params[:q])
    @variants = @q.result.order(sort_column + " " + sort_direction).
                page(pagination_page).per(pagination_rows)
  end

  def show
    @variant = Variant.includes(:product).find(params[:id])
    respond_with(@variant)
  end

  def new
    @variant = @product.variants.new()
  end

  def create
    @variant = @product.variants.new(allowed_params)

    if @variant.save
      redirect_to admin_catalog_product_variants_url(@product)
    else
      flash[:error] = "The variant could not be saved"
      render :action => :new
    end
  end

  def edit
    @variant  = Variant.includes(:properties,:variant_properties, {:product => :properties}).find(params[:id])    
  end

  def update
    @variant = Variant.includes( :product ).find(params[:id])

    if @variant.update_attributes(allowed_params)
      redirect_to admin_catalog_product_variants_url(@variant.product)
    else
      render :action => :edit
    end
  end

  def destroy
    @variant = Variant.find(params[:id])
    @variant.deleted_at = Time.zone.now
    @variant.save

    redirect_to admin_catalog_product_variants_url(@variant.product)
  end

  def current_product
    @product = Product.find(params[:product_id])
  end

  def default_sort_column
    "variants.id"
  end

  private

  def allowed_params
    params.require(:variant).permit(:sku, :name, :price, :cost, :deleted_at, :master, :inventory_id )
  end  
end