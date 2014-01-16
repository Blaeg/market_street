class Catalog::ProductsController < ApplicationController
  add_breadcrumb "Products", :catalog_products_path
  
  def index
    products = Product.includes(:variants).active
    if params[:product_type_id].present? && product_type = ProductType.find_by_id(params[:product_type_id])
      product_types = product_type.self_and_descendants.map(&:id)
      products = products.where('product_type_id IN (?)', product_types)      
    end
    @products = products.decorate
    respond_to do |format|
      format.html { render }
      format.json { render json: @products }
    end
  end

  def create
    if params[:q] && params[:q].present?
      @products = Product.standard_search(params[:q]).results
    else
      @products = Product.where('deleted_at IS NULL OR deleted_at > ?', Time.zone.now )
    end

    render :template => '/products/index'
  end

  def show    
    add_breadcrumb product.name, :catalog_products_path
    @recommended_products = Product.includes(:variants).active.decorate
    form_info
  end

  private

  def form_info
    @cart_item = CartItem.new
    @cart_item.variant_id = @product.active_variants.first.try(:id)
  end

  def featured_product_types
    [ProductType::FEATURED_TYPE_ID]
  end

  def product 
    @product ||= Product.active.find(params[:id])
  end
end
