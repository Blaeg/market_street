class HomesController < ApplicationController
  caches_page :index, :about, :terms  
  add_breadcrumb "Home", :root_path
  def index
    binding.pry
    @featured_product = Product.featured
    @best_selling_products = Product.limit(5)
    @other_products  ## search 2 or 3 categories (maybe based on the user)
    unless @featured_product
      if current_user && current_user.admin?
        redirect_to admin_merchandise_products_url
      else
        redirect_to login_url
      end
    end    
  end

  def about
    add_breadcrumb "About", :about_home_path
  end

  def terms
    add_breadcrumb "Terms", :terms_home_path
  end
end
