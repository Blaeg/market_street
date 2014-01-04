class Shopping::CartsController < Shopping::BaseController
	layout 'light'
  
  def index
  	@cart = session_cart
  end  

  def checkout
  	@cart = session_cart
  	redirect root_url if @cart.nil?  	
  end
end
