require 'spec_helper'

describe Shopping::WishItemsController do
  render_views

  it "redirect to login if no current_user" do
    get :index
    response.should redirect_to(login_url)
  end
end

describe Shopping::WishItemsController do
  render_views
  before(:each) do
    activate_authlogic
    @wish_item = create(:wish_item)
    login_as(@wish_item.user)
  end
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "destroy action should render index template" do
    delete :destroy, :id => @wish_item.id
    expect(WishItem.where(id: @wish_item.id)).to be_empty
    response.should render_template(:index)
  end
end
