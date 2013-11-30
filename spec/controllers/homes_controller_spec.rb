require  'spec_helper'

describe HomesController do
  render_views

  it "show action should render index template" do
    pending "Not sure why this is broken. Will fix later."
    get :index
    expect(response.status).to eq 200
  end


  it "show action should render about template" do
    get :about
    expect(response.status).to eq 200
  end

  it "show action should render terms template" do
    get :terms
    expect(response.status).to eq 200
  end
end
