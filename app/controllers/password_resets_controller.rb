class PasswordResetsController < ApplicationController

  before_filter :load_user_using_perishable_token, :only => [ :edit, :update ]

  def new
    @user = User.new      
  end

  def create
    @user = User.find_by_email(params[:user][:email])
    if @user
      @user.reset_perishable_token!
      EmailWorker::SendPasswordResetInstructions.perform_async(@user.id)                      

      flash[:notice] = 'Instructions to reset your password have been emailed.'
      render :template => '/customer/password_resets/confirmation'
    else
      @user = User.new
      flash[:notice] = 'No user was found with that email address'
      render :action => 'new'
    end
  end

  def edit      
  end

  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
        #@user.activate!
        flash[:notice] = 'Your password has been reset'
        redirect_to login_url
      else
        render :action => :edit
      end
    end

    protected

    def load_user_using_perishable_token
      unless @user = User.find_by_perishable_token( params[:id])
        flash[:notice] = 'The link you used in no longer valid.  Click the password reset link to get a new link to reset your password.'
        redirect_to login_url and return
      end
    end
  end