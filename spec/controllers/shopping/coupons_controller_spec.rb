require 'spec_helper'

describe Shopping::CouponsController do
  render_views

  before(:each) do
    activate_authlogic
    @user = create(:user)
    login_as(@user)
    @variant  = create(:variant)
    create_cart(@user, [@variant])    
  end

  it "create action renders show template when coupon is not eligible" do
    Coupon.any_instance.stubs(:eligible?).returns(false)
    post :create, :coupon => {:code => 'qwerty' }
    expect(response).to be_bad_request
  end

  it "create action redirects when model is valid" do
    create(:coupon_value, :code => 'qwerty' )
    Coupons::CouponValue.any_instance.stubs(:eligible?).returns(true)
    Shopping::CouponsController.any_instance.stubs(:update_order_coupon_id).returns(true)
    post :create, :coupon => {:code => 'qwerty' }
    expect(response).to be_success
  end
end
