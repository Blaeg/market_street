
class UserMailer < ActionMailer::Base
  default from: "admin@marketstreet.com"

  def signup_notification(user_id)
    @user = UserDecorator.decorate(User.find(user_id))
    mail( :to => @user.email_address_with_name, 
          :subject => "Welcome to Market Street")          
  end

  def password_reset_instructions(user_id)
    @user = UserDecorator.decorate(User.find(user_id))
    @url = edit_customer_password_reset_url(:id => @user.perishable_token)
    mail( :to => @user.email_address_with_name, 
          :subject => "Reset Password Instructions")
  end

  def new_referral_credits(referring_user_id, referral_user_id)
    @user = UserDecorator.decorate(User.find(referring_user_id))
    @referral_user = UserDecorator.decorate(User.find(referral_user_id))
    @url = root_url
    @phone_number = I18n.t(:company_phone)
    @company_name = I18n.t(:company)

    mail( :to => @user.email_address_with_name,
          :subject => "Referral Credits have been Applied")
  end

  def referral_invite(referral_id, inviter_id)
    @user = UserDecorator.decorate(User.find(inviter_id))
    @referral = Referral.find(referral_id)
    @url = root_url

    mail(:to => @referral.email,
         :subject => "Referral from #{@user.display_name}")
  end

  def order_confirmation(order_id, invoice_id)
    @invoice = Invoice.find(invoice_id)
    @order = Order.includes(:user).find(order_id)
    @user = UserDecorator.decorate(@order.user)
    @url = root_url
    @site_name = site_name

    mail(:to => @order.email,
     :subject => "Order Confirmation")
  end
end
