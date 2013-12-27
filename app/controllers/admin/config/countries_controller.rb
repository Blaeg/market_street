class Admin::Config::CountriesController < Admin::Config::BaseController
  add_breadcrumb "Countries", :admin_config_countries_path

  def index
    @countries = Country.order(sort_column + " " + sort_direction)
    @active_countries = Country.active.order(sort_column + " " + sort_direction).
                                              page(pagination_page).per(pagination_rows)
  end

  def update
    @country = Country.find(params[:id])
    @country.active = true
    if @country.save
      redirect_to admin_config_countries_url, :notice  => "Successfully activated country."
    else
      render :edit
    end
  end

  def destroy
    @country = Country.find(params[:id])
    @country.active = false
    @country.save
    redirect_to admin_config_countries_url, :notice => "Successfully inactivated country."
  end

  def default_sort_column
    "countries.name"
  end
end
