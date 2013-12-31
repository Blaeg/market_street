class Shopping::CartsController < Shopping::BaseController
	layout 'light'
  def index
  	add_breadcrumb 'Your Shopping Cart', shopping_cart_path
    @cart = session_cart
  end  
end
