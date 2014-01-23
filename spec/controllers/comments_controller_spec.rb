require 'spec_helper'

describe CommentsController do
  render_views
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  
  before do
    activate_authlogic
    login_as(user)
  end

  describe "create action" do 
    let(:note) {'note'}
    let(:comment_attributes) { { note: note, 
        commentable_id: product.id, commentable_type: 'Product'} }
    
    context "when input valid comment attributes" do 
      it "creates comments on product" do 
        expect {
          post :create, :format => :json, comment: comment_attributes
        }.to change(Comment, :count).by(1)
        expect(response).to be_success        
      end
    end

    context "when input invalid comment attribute" do 
      let(:comment_attributes) { { commentable_id: product.id, 
        commentable_type: 'Product'} }
      it "doesn't comments on product and return error" do 
        expect {
          post :create, :format => :json, comment: comment_attributes
        }.to change(Comment, :count).by(0)
        expect(response.status).to eq 406
      end
    end
  end  

  describe "destroy action" do 
    context "logged in as the author" do 
      it "deletes the comment" do
        comment = create(:comment, :user => user)
        expect {
          post :destroy, :format => :json, id: comment.id
        }.to change(Comment, :count).by(-1)
        expect(response).to be_success
      end
    end

    context "not logged in as the author" do 
      it "doesn't delete the comment" do 
        comment = create(:comment)
        expect {
          delete :destroy, :format => :json, id: comment.id
        }.to change(Comment, :count).by(0)
        expect(response.status).to eq 401
      end
    end
  end
end
