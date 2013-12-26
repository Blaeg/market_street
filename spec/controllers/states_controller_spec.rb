require 'spec_helper'

describe StatesController do

  it "index action renders index template" do
    request.env["HTTP_ACCEPT"] = "application/json"
    get :index, :country_id => 2
    expect(response).to be_success
  end
end
