# Image groups allow any variant to have "variant specific" images.  Thus a red shit would show as red an not green.

class Admin::Catalog::ImageGroupsController < Admin::BaseController
  helper_method :sort_column, :sort_direction, :products
  def index
    @image_groups = ImageGroup.order(sort_column + " " + sort_direction).
                      page(pagination_page).per(pagination_rows)
  end

  def show
    @image_group = ImageGroup.find(params[:id])
  end

  def new
    @image_group = ImageGroup.new
  end

  def create
    @image_group = ImageGroup.new(allowed_params)
    if @image_group.save
      redirect_to edit_admin_catalog_image_group_url( @image_group ), :notice => "Successfully created image group."
    else
      render :new
    end
  end

  def edit
    @image_group  = ImageGroup.includes(:images).find(params[:id])
  end

  def update
    @image_group = ImageGroup.find(params[:id])
    if @image_group.update_attributes(allowed_params)
      redirect_to [:admin, :merchandise, @image_group], :notice  => "Successfully updated image group."
    else
      render :edit
    end
  end

  def default_sort_column
    "image_groups.name"
  end    
  
  private

  def allowed_params
    params.require(:image_group).permit!
  end

  def products
    @products ||= Product.all.map{|p|[p.name, p.id]}
  end
end