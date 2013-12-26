require 'spec_helper'

describe Customer::PasswordResetsController do
  render_views

  it "new action renders new template" do
    @user = create(:user)
    get :new
    expect(response).to render_template(:new)
  end

  it "create action renders new template when model is invalid" do
    User.any_instance.stubs(:valid?).returns(false)
    User.any_instance.stubs(:find_by_email).returns(nil)
    post :create, :user => {:email => 'wertyuvc'}
    expect(response).to render_template(:new)
  end

  it "create action redirects when model is valid" do
    @user = create(:user)
    User.any_instance.stubs(:valid?).returns(true)
    User.any_instance.stubs(:find_by_email).returns(@user)
    post :create, :user => {:email => @user.email}
    expect(response).to render_template('password_resets/confirmation')
  end

  it "edit action renders edit template" do
    @user = create(:user)
    get :edit, :id => @user.perishable_token
    expect(response).to render_template(:edit)
  end

  it "update action renders edit template when model is invalid" do
    @user = create(:user)
    User.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @user.perishable_token, :user => {:password => 'testPWD123', :password_confirmation => 'testPWD123'}
    expect(response).to render_template(:edit)
  end

  it "update action redirects when model is valid" do
    @user = create(:user)
    User.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @user.perishable_token, :user => {:password => 'testPWD123', :password_confirmation => 'testPWD123'}
    expect(response).to redirect_to(login_url)
  end
end