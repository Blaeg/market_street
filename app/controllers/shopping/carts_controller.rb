class Shopping::CartsController < Shopping::BaseController
  before_filter :load_cart
	layout 'light'
  
  def index
  	
  end  

  def select_ship_address
    if params[:ship_address_id].present?
      @cart.update_attributes(:ship_address_id => params[:ship_address_id])
      render json: {}, status: :ok
    else
      render json: {}, status: :bad_request
    end  	
  end
  
  def select_bill_address
    if params[:bill_address_id].present?
      @cart.update_attributes(:bill_address_id => params[:bill_address_id])
      render json: {}, status: :ok
    else
      render json: {}, status: :bad_request
    end		
  end


  def review
  	redirect root_url if @cart.nil?  	
  end

  def checkout
    begin      
      if order = CheckoutService.new(@cart).checkout
      	redirect_to shopping_orders_confirmation_path(order)
      else 
      	redirect_to shopping_cart_review_path
      end
    rescue Exception => e
    	Rails.logger.error("uncaught #{e} exception while handling connection: #{e.message}")
      redirect_to shopping_cart_review_path
    end
  end

  private 

  def load_cart
    @cart = session_cart    
  end
end
