class ShippingZone < ActiveRecord::Base
  has_many :shipping_methods
  has_many :states#, :through => :state_shipping_zones

  USA48         = 'USA'
  ALASKA_HAWAII = 'Alaska and Hawaii'
  CANADA        = 'Canada'
  USA_TERRITORY = 'USA Territory'
  INTERNATIONAL = 'International'
  OTHER_STATE   = 'Other States'

  LOCATIONS     = [USA48, ALASKA_HAWAII, CANADA, USA_TERRITORY, INTERNATIONAL, OTHER_STATE]

  validates :name, :presence => true, :length => { :maximum => 255 }

  accepts_nested_attributes_for :states

  def self.create_all
    LOCATIONS.each {|x| find_or_create_by(name: x) }
  end
end