class AboutsController < ApplicationController
  caches_page :show, :terms
  def show
  	add_breadcrumb "About", :about_path
  end

  def terms
  end
end
