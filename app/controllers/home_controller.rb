class HomeController < ApplicationController
  add_breadcrumb "Home", :root_path

  def index
    @featured_product = Product.featured
    @best_selling_products = Product.limit(5)
    @other_products
    
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
