require  'spec_helper'

describe HomeController do
  render_views

  it "show action should render index template" do
    get :index
    response.should render_template(:index)
  end


  it "show action should render about template" do
    get :about
    response.should render_template(:about)
  end

  it "show action should render terms template" do
    get :terms
    response.should render_template(:terms)
  end
end
