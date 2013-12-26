require 'spec_helper'

describe Admin::Customer::CommentsController do
  render_views
  
  before(:each) do
    activate_authlogic
    @customer = FactoryGirl.create(:user)
    @user = FactoryGirl.create(:admin_user)
    login_as(@user)
    @order = create(:order)
  end

  it "index action renders index template" do
    comment = FactoryGirl.create(:comment, :user_id => @customer.id, :commentable => @customer)
    get :index, :user_id => @customer.id
    expect(response).to render_template(:index)
  end

  it "show action renders show template" do
    comment = FactoryGirl.create(:comment, :user_id => @customer.id, :commentable => @customer)
    get :show, :id => comment.id, :user_id => @customer.id
    expect(response).to render_template(:show)
  end

  it "new action renders new template" do
    get :new, :user_id => @customer.id
    expect(response).to render_template(:new)
  end

  it "create action renders new template when model is invalid" do
    comment = FactoryGirl.build(:comment, :user_id => @customer.id, :commentable => @customer)
    Comment.any_instance.stubs(:valid?).returns(false)
    post :create, :user_id => @customer.id, :comment => comment.attributes.reject {|k,v| ['id', 'commentable_type', 'commentable_id', 'created_by', 'user_id'].include?(k)}
    expect(response).to render_template(:new)
  end

  it "create action redirects when model is valid" do
    comment = FactoryGirl.build(:comment, :user_id => @customer.id, :commentable => @customer)
    Comment.any_instance.stubs(:valid?).returns(true)
    post :create, :user_id => @customer.id, :comment => comment.attributes.reject {|k,v| ['id', 'commentable_type', 'commentable_id', 'created_by', 'user_id'].include?(k)}
    expect(response).to redirect_to(admin_customer_user_comment_url(@customer, assigns[:comment]))
  end

end
