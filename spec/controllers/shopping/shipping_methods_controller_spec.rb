require 'spec_helper'

describe Shopping::ShippingMethodsController do
  render_views

  before(:each) do
    activate_authlogic

    @cur_user = create(:user)
    login_as(@cur_user)

    #stylist_cart
    @variant  = create(:variant)

    create_cart(@cur_user, [@variant])

    @address      = create(:address)
    @order        = create(:order, :ship_address_id => @address.id)
    @order_item   = create(:order_item, :order => @order, :variant => @variant)
    @order.stubs(:order_items).returns([@order_item])
    @controller.stubs(:find_or_create_order).returns(@order)
  end

  it "index action renders index template" do
    get :index
    expect(response).to render_template(:index)
  end
end
describe Shopping::ShippingMethodsController do
  render_views

  before(:each) do
    activate_authlogic

    @cur_user = create(:user)
    login_as(@cur_user)

    #stylist_cart
    @variant  = create(:variant)

    create_cart(@cur_user, [@variant])

  end
  it "update action renders edit template when model is invalid" do
    @variant2  = create(:variant)
    @address      = create(:address)
    @order        = create(:order, :ship_address => @address)
    @order_item   = create(:order_item, :order => @order, :variant => @variant)
    @order_item2   = create(:order_item, :order => @order, :variant => @variant2)
    @order.stubs(:order_items).returns([@order_item, @order_item2])
    @controller.stubs(:find_or_create_order).returns(@order)

    @shipping_rate = create(:shipping_rate)
    @shipping_method = create(:shipping_method)
    put :update, :id => @shipping_method.id                 
    expect(response).to redirect_to(shopping_checkout_path)
  end

  it "update action redirects when model is valid" do

    @address      = create(:address)
    @order        = create(:order, :ship_address => @address)
    @order_item   = create(:order_item, :order => @order, :variant => @variant)
    @order.stubs(:order_items).returns([@order_item])
    @controller.stubs(:find_or_create_order).returns(@order)

    @shipping_rate = create(:shipping_rate)
    @shipping_method = create(:shipping_method)
    @controller.stubs(:not_secure?).returns(false)
    @controller.stubs(:next_form_url).returns(shopping_checkout_path)
    ShippingMethod.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @shipping_method.id
    expect(response).to redirect_to(shopping_checkout_path)
  end
end
