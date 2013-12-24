require 'spec_helper'

describe Customer::UserSessionsController do
  describe "#create" do
    context "when login fails" do
      it "displays a message with login failure and render the login template" do
        post :create, :user_session => {:email => 'test@test.com'}
        flash[:alert].should == I18n.t('login_failure')
        response.should redirect_to login_url
      end
    end
  end

  describe "#destroy" do
    let(:user) { create(:user) }
    let(:user_session) { UserSession.create :email => user.email, :password => 'password' }

    before do
      subject.stubs(:current_user_session).returns(user)
    end

    it "displays a message with logout success and render the login template" do
      post :destroy
      flash[:notice].should == I18n.t('logout_successful')
      response.should redirect_to login_url
    end
  end
end
