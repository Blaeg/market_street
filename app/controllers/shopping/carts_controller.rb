class Shopping::CartsController < Shopping::BaseController
	layout 'light'
  
  def index
  	@cart = session_cart
  end  

  def checkout
  	@cart = session_cart
  end
end
