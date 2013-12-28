class Admin::OnboardController < Admin::BaseController
  layout "admin"
  before_filter :verify_admin

  def index
    add_breadcrumb "On Board", :admin_onboard_path
  
    if User.count == 0
      @user = User.new(new_user_args)
      if @user.active? || @user.activate!
        @user.save
        @user.role_ids = Role.all.map{|r| r.id }
        @user.save
        @current_user = @user
        @user_session = UserSession.new(session_args)
        @user_session.save
      end    
    end
  end

  private
  
  def session_args
    @session_args ||= { :email => @user.email, :password => @password }
  end

  def new_user_args
    @password ||= "admin_user_#{rand(1000)}"
    @args ||= {
      :first_name => 'Admin',
      :last_name => 'User',
      :email => 'admin@notarealemail.com',
      :password => @password,
      :password_confirmation => @password }
  end
end
