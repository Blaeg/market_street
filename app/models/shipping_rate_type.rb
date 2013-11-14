## This class is to identify if the item is charged separately or at an order-wide basis
#  Example heavy items might need to be charged individually
#  => where other things can be all shipped in one box and charged once
class ShippingRateType < ActiveRecord::Base

  has_many :shipping_rates

  INDIVIDUAL  = 'Individual'
  ORDER       = 'Order'

  TYPES = [INDIVIDUAL, ORDER]


  INDIVIDUAL_ID  = 1
  ORDER_ID       = 2

  def self.create_all
    TYPES.each {|x| find_or_create_by(name: x) }
  end
end
