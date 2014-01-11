module Variant::AvailabilityManager
  OUT_OF_STOCK_QTY        = 0
  LOW_STOCK_QTY           = 2

  def active?
    deleted_at.nil? || deleted_at > Time.zone.now
  end

  # This is a form helper to inactivate a variant
  def inactivate=(val)
    self.deleted_at = Time.zone.now if !deleted_at && (val && (val == '1' || val.to_s == 'true'))
  end

  def inactivate
    deleted_at.present?
  end

  def quantity_purchaseable
    quantity_available - OUT_OF_STOCK_QTY
  end

  def purchaseable_quantity(quantity_desired)
    [quantity_available, quantity_desired].min
  end

  def quantity_available
    (count_on_hand - count_pending_to_customer)
  end

  def sold_out?
    (quantity_available) <= OUT_OF_STOCK_QTY
  end

  def low_stock?
    (quantity_available) <= LOW_STOCK_QTY
  end

  def display_stock_status(start = '(', finish = ')')
    return "#{start}Sold Out#{finish}"  if sold_out?
    return "#{start}Low Stock#{finish}" if low_stock?
    ''
  end

  def stock_status
    return "sold_out" if sold_out?
    return "low_stock" if low_stock?
    "available"
  end

  def is_available?
    count_available > 0
  end

  def count_available(reload_variant = true)
    self.reload if reload_variant
    count_on_hand - count_pending_to_customer
  end

  #ACTIONS
  # with SQL math add to count_on_hand attribute
  #
  # @param [Integer] number of variants to add
  # @return [none]
  def add_count_on_hand(num)
    ### don't lock if we have plenty of stock.
    if low_stock?
      inventory.lock!
      self.inventory.count_on_hand = inventory.count_on_hand + num.to_i
      inventory.save!
    else
      sql = "UPDATE inventories 
            SET count_on_hand = (#{num} + count_on_hand) 
            WHERE id = #{self.inventory.id}"
      ActiveRecord::Base.connection.execute(sql)
    end
  end

  # with SQL math subtract to count_on_hand attribute
  #
  # @param [Integer] number of variants to subtract
  # @return [none]
  def subtract_count_on_hand(num)
    add_count_on_hand((num.to_i * -1))
  end

  # with SQL math add to count_pending_to_customer attribute
  #
  # @param [Integer] number of variants to add
  # @return [none]
  def add_pending_to_customer(num = 1)
    ### don't lock if we have plenty of stock.
    if low_stock?
      # If the stock is low lock the inventory.  This ensures
      inventory.lock!
      self.inventory.count_pending_to_customer = inventory.count_pending_to_customer.to_i + num.to_i
      inventory.save!
    else
      sql = "UPDATE inventories 
            SET count_pending_to_customer = (#{num} + count_pending_to_customer) 
            WHERE id = #{self.inventory.id}"
      ActiveRecord::Base.connection.execute(sql)
    end
  end

  # with SQL math subtract to count_pending_to_customer attribute
  #
  # @param [Integer] number of variants to subtract
  # @return [none]
  def subtract_pending_to_customer(num)
    add_pending_to_customer((num.to_i * -1))
  end

  # in the admin form qty_to_add to the count on hand
  #
  # @param [Integer] number of variants to add or subtract (negative sign is subtract)
  # @return [none]
  def qty_to_add=(num)
    ###  TODO this method needs a history of who did what
    inventory.lock!
    self.inventory.count_on_hand = inventory.count_on_hand.to_i + num.to_i
    inventory.save!
  end

  # method used by forms to set the initial qty_to_add for variants
  #
  # @param [none]
  # @return [Integer] 0
  def qty_to_add
    0
  end
end