class Shopping::CartsController < Shopping::BaseController
	layout 'light'
  
  def index
  	@cart = session_cart
  end  

  def review
  	@cart = session_cart
  	redirect root_url if @cart.nil?  	
  end

  def checkout
    begin
      order =CheckoutService.new(session_cart).checkout
      if order
      	redirect_to shopping_orders_confirmation_path(order)
      else 
      	redirect_to shopping_cart_review_path
      end
    rescue Exception => e
    	Rails.logger.error("uncaught #{e} exception while handling connection: #{e.message}")
      redirect_to shopping_cart_review_path
    end
  end
end
