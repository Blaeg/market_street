require 'spec_helper'

describe Admin::Offer::CouponsController do
  render_views

  before(:each) do
    activate_authlogic
    @user = create_admin_user
    login_as(@user)
  end

  it "index action renders index template" do
    get :index
    expect(response).to render_template(:index)
  end

  it "show action renders show template" do
    @coupon = create(:coupon)
    get :show, :id => @coupon.id
    expect(response).to render_template(:show)
  end

  it "new action renders new template" do
    get :new
    expect(response).to render_template(:new)
  end

  it "create action renders new template when model is invalid" do
    @coupon = create(:coupon)
    Coupon.any_instance.stubs(:valid?).returns(false)
    attribs =  @coupon.attributes
    attribs.delete('type')
    post :create, :coupon => attribs, :c_type => 'CouponValue'
    expect(response).to render_template(:new)
  end

  it "create action redirects when model is valid" do
    @coupon = create(:coupon_value)
    Coupons::CouponValue.any_instance.stubs(:valid?).returns(true)
    attribs =  @coupon.attributes
    attribs.delete('type')
    post :create, :coupon => attribs, :c_type => 'CouponValue'
    expect(response).to redirect_to(admin_offer_coupon_url(assigns[:coupon]))
  end

  it "edit action renders edit template" do
    @coupon = create(:coupon)
    get :edit, :id => @coupon.id
    expect(response).to render_template(:edit)
  end

  it "update action renders edit template when model is invalid" do
    @coupon = create(:coupon)
    attribs =  @coupon.attributes
    attribs.delete('type')
    Coupons::CouponValue.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @coupon.id, :coupon => attribs
    expect(response).to render_template(:edit)
  end

  it "update action redirects when model is valid" do
    @coupon = create(:coupon)
    attribs =  @coupon.attributes
    attribs.delete('type')
    Coupons::CouponValue.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @coupon.id, :coupon => attribs
    expect(response).to redirect_to(admin_offer_coupon_url(assigns[:coupon]))
  end

  it "destroy action should destroy model and redirect to index action" do
    @coupon = create(:coupon)
    delete :destroy, :id => @coupon.id
    expect(response).to redirect_to(admin_offer_coupons_url)
    Coupon.exists?(@coupon.id).should be_false
  end
end
