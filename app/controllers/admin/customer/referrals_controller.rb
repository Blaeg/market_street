class Admin::Customer::ReferralsController < Admin::BaseController
  helper_method :sort_column, :sort_direction, :referral_types, :referral_programs
  def index
    @referrals = Referral.order(sort_column + " " + sort_direction).
    page(pagination_page).per(pagination_rows)
  end

  def show
    @referral = Referral.find(params[:id])
  end

  def new
    @referral = Referral.new    
  end

  def create
    @referring_user = User.find_by_email(params[:referring_user_email])
    @referral = Referral.new(allowed_params)
    @referral.skip_validate_has_not_signed_up_yet = true
    if @referring_user
      @referral.referring_user_id = @referring_user.id

      @new_user = User.find_by_email(@referral.email)
      if @new_user
        @referral.referral_user_id = @new_user.id
        if @new_user.number_of_finished_orders > 0
          @referral.purchased_at  = @new_user.finished_orders.first.completed_at
          @referral.registered_at = @new_user.created_at

        end
      end
      if @referral.save
        redirect_to [:admin, :customer, @referral], :notice => "Successfully created referral."
      else
        render :new
      end
    else
      flash[:alert] = "Could not find a user with the email #{params[:referring_user_email]}"
      render :new
    end
  end

  def edit
    @referral = Referral.find(params[:id])    
  end

  def update
    @referral = Referral.find(params[:id])
    if @referral.update_attributes(allowed_params)
      redirect_to [:admin, :customer, @referral], :notice  => "Successfully updated referral."
    else
      render :edit
    end
  end

  def apply
    Referral.unapplied.purchased.find_each do |referral|
      referral.give_credits!
    end
    redirect_to admin_customer_referrals_path
  end

  def destroy
    @referral = Referral.find(params[:id])
    @referral.destroy
    redirect_to admin_customer_referrals_url, :notice => "Successfully destroyed referral."
  end

  def default_sort_column
    "referrals.name"    
  end

  private

  def allowed_params
    params.require(:referral).permit(:email, :name, :referral_program_id)
  end

  def referral_programs
    return @referral_programs if @referral_programs
    @referral_programs = ReferralProgram.all.map{|u| [u.name, u.id]}
  end

  def referral_types
    return @referral_types if @referral_types
    @referral_types = ReferralType.all.map{|u| [u.name, u.id]}
  end
end