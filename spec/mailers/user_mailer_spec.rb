require 'spec_helper'

describe UserMailer, "Signup Email" do
  include Rails.application.routes.url_helpers

  let(:user) { create(:user, :email => 'myfake@email.com', 
    :first_name => 'Alex', :last_name => 'Commerce')}
  let(:email) { UserMailer.signup_notification(user.id) }
    
  it "is set to be delivered to the email passed in" do
    expect(email).to deliver_to("Alex Commerce <myfake@email.com>")
  end

  it "contains the user's message in the mail body" do
    expect(email).to have_body_text(/Alex Commerce/)
  end

  it "has the correct subject" do
    expect(email).to have_subject(/Welcome/)
  end
end

describe UserMailer, "password_reset_instructions" do 
  let(:user) { create(:user, :email => 'myfake@email.com', 
    :first_name => 'Alex', :last_name => 'Commerce')}
  let(:email) { UserMailer.password_reset_instructions(user.id) }

  it "is set to be delivered to the email passed in" do
    expect(email).to deliver_to("Alex Commerce <myfake@email.com>")
  end

  it "has the correct subject" do
    expect(email).to have_subject(/Reset Password Instructions/)
  end
end


describe UserMailer, "#new_referral_credits" do
  include Rails.application.routes.url_helpers

  let(:referring_user) { create(:user, :email => 'referring_user@email.com', 
    :first_name => 'Alex', :last_name => 'Commerce')}
  let(:referral) { create(:referral, :email => 'referral_user@email.com', 
    :referring_user => referring_user )}
  let(:referral_user) { create(:user, :email => 'referral_user@email.com', 
    :first_name => 'Alex', :last_name => 'referral')}
  
  let(:email) { UserMailer.new_referral_credits(referring_user.id, 
    referral_user.id)}

  it "is set to be delivered to the email passed in" do
    expect(email).to deliver_to("Alex Commerce <referring_user@email.com>")
  end

  it "has the correct subject" do
    expect(email).to have_subject(/Referral Credits have been Applied/)
  end
end

describe UserMailer, "#referral_invite(referral_id, inviter_id)" do
  include Rails.application.routes.url_helpers
  let(:referring_user) { create(:user, :email => 'referring_user@email.com', 
    :first_name => 'Alex', :last_name => 'Commerce') }
  let(:referral) { create(:referral, :email => 'referral_user@email.com', 
    :referring_user => referring_user ) }
  let(:email) {UserMailer.referral_invite(referral.id, referring_user.id)}
  
  it "is set to be delivered to the email passed in" do
    expect(email).to deliver_to("referral_user@email.com")
  end

  it "has the correct subject" do
    expect(email).to have_subject(/Referral from Alex/)
  end
end

describe UserMailer, "#order_confirmation" do
  include Rails.application.routes.url_helpers

  before(:each) do
    @user         = create(:user, :email => 'myfake@email.com', :first_name => 'Alex', :last_name => 'Commerce')
    @order_item   = create(:order_item)
    @order        = create(:order, :email => 'myfake@email.com', :user => @user)
    @invoice        = create(:invoice, :order => @order)
    @order.stubs(:order_items).returns([@order_item])
    @email = UserMailer.order_confirmation(@order.id, @invoice.id)
  end

  it "is set to be delivered to the email passed in" do
    @email.should deliver_to("myfake@email.com")
  end

  it "contains the user's message in the mail body" do
    @email.should have_body_text(/Alex Commerce/)
  end

  #it "contains a link to the confirmation link" do
  #  @email.should have_body_text(/#{confirm_account_url}/)
  #end

  it "has the correct subject" do
    @email.should have_subject(/Order Confirmation/)
  end
end