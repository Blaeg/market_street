class ProductDecorator < Draper::Decorator
  delegate_all

  def price
    active_variants.present? ? price_range.first : raise( VariantRequiredError )
  end

  def price_range?
    !(price_range.first == price_range.last)
  end
  
  def price_range
    return @price_range if @price_range
    return @price_range = ['N/A', 'N/A'] if active_variants.empty?
    @price_range = active_variants.minmax {|a,b| a.price <=> b.price }.map(&:price)
  end

  def price_label
  	str = ActionController::Base.helpers.number_to_currency(self.price_range.first)  	
  	if price_range?        		
  		str += '-'+ ActionController::Base.helpers.number_to_currency(product.price_range.last) 
  	end
  	str
  end  

  def short_name
  	name[0..20]
  end
end
