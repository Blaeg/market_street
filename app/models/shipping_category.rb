class ShippingCategory < ActiveRecord::Base
  has_many :products
  has_many :shipping_rates

  validates :name, :presence => true,       :length => { :maximum => 255 }

  CATEGORIES = ['table', 'sofa', 'chair', 'rug']

  def self.create_all
    CATEGORIES.each {|x| find_or_create_by(name: x) }
  end
end
