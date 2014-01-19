class Shopping::CouponsController < Shopping::BaseController
  def create
    @coupon = Coupon.find_by_code(params[:coupon][:code])
    if @coupon && @coupon.eligible?(session_cart) && 
      session_cart.update_attributes(:coupon_id => @coupon.id )
      render json: {:notice => "Successfully added coupon code #{@coupon.code}."}, 
        status: :ok      
    else
      render json: {:notice => "Sorry coupon code: #{params[:coupon][:code]} is not valid."}, 
        status: :bad_request            
    end
  end

  private

  def form_info
    @coupon = Coupon.new
  end
end