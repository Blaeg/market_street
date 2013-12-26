class Customer::ReferralsController < Customer::BaseController
  
  def index
    @referral  = Referral.new
    @referrals = current_user.referrals.order(sort_column + " " + sort_direction)
  end

  def create
    @referral = current_user.referrals.new(allowed_params)
    if @referral.save
      redirect_to customer_referrals_url, :notice => "Successfully created referral."
    else
      @referrals = current_user.referrals.order(sort_column + " " + sort_direction)
      render :index
    end
  end

  def update
    @referral = current_user.referrals.find(params[:id])
    if @referral.update_attributes(allowed_params)
      redirect_to customer_referrals_url, :notice  => "Successfully updated referral."
    else
      @referrals = current_user.referrals.order(sort_column + " " + sort_direction)
      render :index
    end
  end

  def default_sort_column
    "referrals.name"
  end

  private

  def allowed_params
    params.require(:referral).permit(:email, :name)
  end

  def selected_customer_tab(tab)
    tab == 'referrals'
  end  
end
