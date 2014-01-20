class ProductDecorator < Draper::Decorator
  delegate_all

  def price_label
  	str = ActionController::Base.helpers.number_to_currency(self.price_range.first)  	
  	if product.price_range?        		
  		str += '-'+ ActionController::Base.helpers.number_to_currency(product.price_range.last) 
  	end
  	str
  end  

  def short_name
  	product.name[0..20]
  end
end
