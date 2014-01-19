class Shopping::CartsController < Shopping::BaseController
  before_filter :load_cart
	layout 'min_nav'
  
  def index
  
  end

  def update
    if @cart.update_attributes allowed_params
      render json: {}, status: :ok
    else
      render json: {}, status: :bad_request
    end  	
  end
  
  def review
    return redirect_to root_url if @cart.nil? or @cart.cart_items.empty?
    @ship_address = Address.new if @cart.ship_address_id.nil? 
    @bill_address = Address.new if @cart.bill_address_id.nil?      
  end

  def checkout
    begin      
      if order = CheckoutService.new(@cart).checkout
      	redirect_to confirmation_shopping_order_path(order)
      else 
      	redirect_to shopping_cart_review_path
      end
    rescue Exception => e
    	Rails.logger.error("uncaught #{e} exception while handling connection: #{e.message}")
      redirect_to shopping_cart_review_path
    end
  end

  private 
  
  def allowed_params
    params.require(:cart).permit(:ship_address_id, :bill_address_id)
  end

  def load_cart
    @cart = session_cart    
  end
end
