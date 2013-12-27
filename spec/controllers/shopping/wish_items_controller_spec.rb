require 'spec_helper'

describe Shopping::WishItemsController do
  render_views

  context "not login" do 
    it "redirect to login if no current_user" do
      get :index
      expect(response).to redirect_to(login_url)
    end
  end

  context "login" do 
    before(:each) do
      activate_authlogic
      @wish_item = create(:wish_item)
      login_as(@wish_item.user)
    end
    
    it "index action renders index template" do
      get :index
      expect(response).to render_template(:index)
    end
      
    it "creates an wish item" do      
      variant = create(:variant)
      expect{
        post :create, format: :json, variant_id: variant.id 
      }.to change(WishItem, :count).by(1)
      expect(response).to be_success
    end    

    it "destroy action renders index template" do      
      expect{
        delete :destroy, format: :json, :id => @wish_item.id        
      }.to change(WishItem, :count).by(-1)      
      expect(response).to be_success
    end    
  end
end