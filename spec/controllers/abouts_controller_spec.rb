require  'spec_helper'

describe AboutsController do
  render_views

  it "show action should render show template" do
    get :show
    response.should render_template(:show)
  end

  it "index action should render terms template" do
    get :terms
    response.should render_template(:terms)
  end
end
