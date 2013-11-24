class AboutsController < ApplicationController
  add_breadcrumb "Home", :root_path
  def show
  	add_breadcrumb "About", :about_path
  end
end
