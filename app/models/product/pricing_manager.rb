module Product::PricingManager
  def price
    active_variants.present? ? price_range.first : raise( VariantRequiredError )
  end

  def display_price_range(j = ' to ')
    price_range.join(j)
  end

  # range of the product prices (Just teh low and high price) as an array
  #
  # @param [none]
  # @return [Array] [Low price, High price]
  def price_range
    return @price_range if @price_range
    return @price_range = ['N/A', 'N/A'] if active_variants.empty?
    @price_range = active_variants.minmax {|a,b| a.price <=> b.price }.map(&:price)
  end

  # Answers if the product has a price range or just one price.
  #   if there is more than one price returns true
  #
  # @param [none]
  # @return [Boolean] true == there is more than one price
  def price_range?
    !(price_range.first == price_range.last)
  end
end