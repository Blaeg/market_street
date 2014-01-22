class Customer::OverviewsController < Customer::BaseController
  def edit
    @user = UserDecorator.decorate(current_user)
  end

  def update
    @user = UserDecorator.decorate(current_user)
    if @user.update_attributes(user_params)
      redirect_to customer_overview_url(), :notice  => "Successfully updated user."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation, 
      :first_name, :last_name, :app_theme, :nav_bar_inverse)
  end

  def selected_customer_tab(tab)
    tab == 'profile'
  end
end
