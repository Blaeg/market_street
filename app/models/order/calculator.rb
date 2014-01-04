module Order::Calculator
  
  def find_total(force = false)
  	calculate_totals if self.calculated_at.nil? || order_items.any? {|item| (item.updated_at > self.calculated_at) }
  	self.deal_time ||= Time.zone.now
  	self.deal_amount = Deal.best_qualifing_deal(self)
  	self.find_sub_total
  	self.total        = (self.sub_total + shipping_amount - deal_amount - coupon_amount ).round_at( 2 )
  	self.taxed_total  = (taxable_subtotal_amount + shipping_amount).round_at( 2 )
  end

  def taxable_subtotal_amount 
    (self.sub_total - deal_amount - coupon_amount) * ((100.0 + order_tax_percentage) / 100.0)
  end

  def find_sub_total
  	order_items.map do |item|
  		self.total + item.item_total
  	end.sum  	
  end

  def calculate_totals
    # if calculated at is nil then this order hasn't been calculated yet
    # also if any single item in the order has been updated, the order needs to be re-calculated
    if any_order_item_needs_to_be_calculated? && all_order_items_are_ready_to_calculate?
      calculate_each_order_items_total
      sub_total = total
      self.total = total + shipping_amount
      self.calculated_at = Time.zone.now
      save
    end
  end

  def coupon_amount
  	coupon_id ? coupon.value(item_prices, self) : 0.0
  end

  def credited_total
  	(find_total - amount_to_credit).round_at( 2 )
  end

  def amount_to_credit
  	[find_total, user.store_credit.amount].min.to_f.round_at( 2 )
  end

  # def all_order_items_have_a_shipping_rate?
  #   !order_items.any?{ |item| item.shipping_rate_id.nil? }
  # end

  #TAX
  def taxed_amount
    (get_taxed_total - total).round_at( 2 )
  end

  def get_taxed_total
    taxed_total || find_total
  end

  def order_tax_percentage
    (!order_items.blank? && order_items.first.tax_rate.try(:percentage)) ? order_items.first.tax_rate.try(:percentage) : 0.0
  end

  def tax_charges
  	order_items.map(&:tax_charge)
  end

  def total_tax_charges
  	tax_charges.sum
  end

  def update_tax_rates
    if ship_address_id_changed?
      # set_beginning_values
      tax_time = completed_at? ? completed_at : Time.zone.now
      order_items.each do |item|
        rate = item.variant.product.tax_rate(self.ship_address.state_id, tax_time)
        if rate && item.tax_rate_id != rate.id
          item.tax_rate = rate
          item.save
        end
      end
    end
  end

  #SHIPPING
  def shipping_amount
    order_items.map(&:shipping_amount).sum    
  end

  private 

  def any_order_item_needs_to_be_calculated?
    calculated_at.nil? || (order_items.any? {|item| (item.updated_at > self.calculated_at) })
  end

  def all_order_items_are_ready_to_calculate?
    order_items.all? {|item| item.ready_to_calculate? }
  end

  def calculate_each_order_items_total(force = false)
    self.total = 0.0
    tax_time = completed_at? ? completed_at : Time.zone.now
    order_items.each do |item|
      if (calculated_at.nil? || item.updated_at > self.calculated_at)
        item.tax_rate = item.variant.product.tax_rate(self.ship_address.state_id, tax_time)
        item.calculate_total
        item.save
      end
      self.total = total + item.total
    end
  end

  def item_prices
    order_items.map(&:adjusted_price)
  end
end
