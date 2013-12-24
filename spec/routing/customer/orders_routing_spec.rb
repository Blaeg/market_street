require "spec_helper"

describe Customer::OrdersController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/customer/orders" }.should route_to(:controller => "customer/orders", :action => "index")
    end

  end
end
