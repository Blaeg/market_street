class Customer::RegistrationsController < ApplicationController
  layout 'lean'

  def new
    @registration = true
    @user         = User.new
    @user_session = UserSession.new    
  end

  def create
    @user = User.new(allowed_params)
    # Saving without session maintenance to skip
    # auto-login which can't happen here because
    # the User has not yet been activated
    if @user.save_without_session_maintenance
      EmailWorker::SendSignUpNotification.perform_async(@user.id)
      #cookies[:MarketStreet_uid] = @user.access_token
      #session[:authenticated_at] = Time.now
      #cookies[:insecure] = false
      UserSession.new(@user.attributes)
      flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions!"
      redirect_to root_url
    else
      @registration = true
      @user_session = UserSession.new
      flash[:notice] = "There is an error. Please try again."      
      redirect_to new_customer_registration_url
    end
  end

  protected

  def allowed_params
    params.require(:user).permit(:password, :password_confirmation, :first_name, :last_name, :email)
  end
end