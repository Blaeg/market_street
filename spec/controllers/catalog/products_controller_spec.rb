require 'spec_helper'

describe Catalog::ProductsController do
  render_views

  before(:each) do
    @product = create(:product)
    @variant = create(:variant, :product => @product)
    @variant.stubs(:primary_property).returns(nil)
    @variant.stubs(:properties).returns(nil)
    @product.activate!
  end

  it "index action renders index template" do
    get :index
    expect(response).to render_template(:index)
  end

  it "show action should not blow up without a property association" do
    get :show, :id => @product.permalink
    expect(response).to render_template(:show)
  end
end
