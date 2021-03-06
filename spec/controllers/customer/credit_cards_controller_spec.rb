require 'spec_helper'

describe Customer::CreditCardsController do
  render_views

  before(:each) do
    activate_authlogic
    @user = create(:user)
    login_as(@user)
  end

  it "index action renders index template" do
    get :index
    expect(response).to render_template(:index)
  end

  it "show action renders show template" do
    @credit_card = create(:payment_profile, :user => @user)
    get :show, :id => @credit_card.id
    expect(response).to render_template(:show)
  end

  it "new action renders new template" do
    get :new
    expect(response).to render_template(:new)
  end

  it "create action renders new template when model is invalid" do
    PaymentProfile.any_instance.stubs(:valid?).returns(false)
    credit_card = build(:payment_profile)
    post :create, :credit_card => credit_card.attributes
    expect(response).to render_template(:new)
  end

  it "create action redirects when model is valid" do
    PaymentProfile.any_instance.stubs(:valid?).returns(false)
    PaymentProfile.any_instance.stubs(:create_payment_profile).returns(true)
    credit_card = build(:payment_profile)
    post :create, :credit_card => credit_card.attributes#.merge(:credit_card_info)
  end

  it "edit action renders edit template" do
    @credit_card = create(:payment_profile, :user => @user)
    get :edit, :id => @credit_card.id
    expect(response).to render_template(:edit)
  end

  it "update action renders edit template when model is invalid" do
    @credit_card = create(:payment_profile, :user => @user)
    PaymentProfile.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @credit_card.id, :credit_card => @credit_card.attributes
    expect(response).to render_template(:edit)
  end

  it "update action redirects when model is valid" do
    @credit_card = create(:payment_profile, :user => @user)
    PaymentProfile.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @credit_card.id, :credit_card => @credit_card.attributes
    expect(response).to redirect_to(customer_credit_card_url(assigns[:credit_card]))
  end

  it "destroy action should inactivate model and redirect to index action" do
    @credit_card = create(:payment_profile, :user => @user)
    delete :destroy, :id => @credit_card.id
    expect(response).to redirect_to(customer_credit_cards_url)
    PaymentProfile.exists?(@credit_card.id).should be_true

    c = PaymentProfile.find(@credit_card.id)
    c.active.should be_false
  end
end

describe Customer::CreditCardsController do
  render_views

  it "index action should go to login page" do
    get :index
    expect(response).to redirect_to(login_url)
  end

  it "show action should go to login page" do
    @credit_card = create(:payment_profile)
    get :show, :id => @credit_card.id
    expect(response).to redirect_to(login_url)
  end
end
