class Customer::UserSessionsController < ApplicationController
  layout 'lean'
  
  def new    
    add_breadcrumb "Sign In", :new_customer_user_session_path
    @user_session = UserSession.new
    @user = User.new
  end

  def create
    @user_session = UserSession.new(user_params)
    if @user_session.save
      cookies[:MarketStreet_uid] = @user_session.record.access_token
      session[:authenticated_at] = Time.now
      cookies[:insecure] = false
      ## if there is a cart make sure the user_id is correct
      set_user_to_cart_items
      flash[:notice] = I18n.t('login_successful')
      redirect_back_or_default
    else
      @user = User.new(user_params)
      redirect_to login_url, :alert => I18n.t('login_failure')
    end
  end

  def destroy
    current_user_session.destroy
    reset_session
    cookies.delete(:MarketStreet_uid)
    redirect_to login_url, :notice => I18n.t('logout_successful')
  end

  private

  def user_params
    params.require(:user_session).permit(:password, :password_confirmation, :first_name, :last_name, :email)
  end

  def set_user_to_cart_items
    if session_cart.user_id != @user_session.record.id
      session_cart.update_attribute(:user_id, @user_session.record.id )
    end  
  end
end
