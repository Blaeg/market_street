# == Schema Information
#
# Table name: shipping_methods
#
#  id               :integer(4)      not null, primary key
#  name             :string(255)     not null
#  created_at       :datetime
#  updated_at       :datetime
#

class ShippingMethod < ActiveRecord::Base
  has_many :shipping_rates
  
  validates  :name,  :presence => true,       :length => { :maximum => 255 }
  
  def descriptive_name
    name.humanize
  end

  METHODS = ['fedex', 'white_glove']
  def self.create_all
    METHODS.each {|x| find_or_create_by(name: x) }
  end
end
