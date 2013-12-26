class Admin::Catalog::PropertiesController < Admin::BaseController
  add_breadcrumb "Properties", :admin_catalog_properties_path
  respond_to :html, :json
  
  def index
    @q = Property.search(params[:q])
    @properties = @q.result.order(sort_column + " " + sort_direction).
                    page(pagination_page).per(pagination_rows)
  end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(allowed_params)
    if @property.save
      redirect_to :action => :index
    else
      flash[:error] = "The property could not be saved"
      render :action => :new
    end
  end

  def edit
    @property = Property.find(params[:id])
  end

  def update
    @property = Property.find(params[:id])
    if @property.update_attributes(allowed_params)
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end

  def destroy
    @property = Property.find(params[:id])
    @property.active = false
    @property.save

    redirect_to :action => :index
  end

  def default_sort_column
    "properties.identifing_name"
  end
  
  private

  def allowed_params
    params.require(:property).permit(:identifing_name, :display_name, :active)
  end
end
