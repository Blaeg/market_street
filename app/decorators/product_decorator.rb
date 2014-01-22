class ProductDecorator < Draper::Decorator
  delegate_all
  SHORT_LENGTH = 20
  
  def short_name
    name[0..SHORT_LENGTH-1]
  end

  def price
    variant_prices.first
  end

  def price_range
    [variant_prices.first, variant_prices.last]    
  end

  def price_label
    return price unless price_range?
    price_range.map { |pr|
      ActionController::Base.helpers.number_to_currency(pr)
    }.join('-')  	
  end  

  private 

  def price_range?
    variant_prices.first != variant_prices.last
  end

  def variant_prices 
    raise( VariantRequiredError ) if active_variants.empty?
    @variant_prices ||= active_variants.map(&:price).sort
  end
end
