class AboutsController < ApplicationController
  def show
  	add_breadcrumb "About", :about_path
  end
end
