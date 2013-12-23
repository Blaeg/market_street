class Property < ActiveRecord::Base
  BASIC = ['brand', 'color', 'material', 'size']

  has_many :prototype_properties
  has_many :prototypes, :through => :prototype_properties

  has_many :product_properties
  has_many :products, :through => :product_properties

  has_many :variant_properties
  has_many :variants, :through => :variant_properties

  validates :identifing_name, :presence => true, :length => { :maximum => 250 }
  validates :display_name, :presence => true, :length => { :maximum => 165 }
  
  scope :visible, -> {where(active: true)}

  def full_name
    "#{display_name}: (#{identifing_name})"
  end
  
  # 'True' if active 'False' otherwise in plain english
  #
  # @param [none]
  # @return [String] 'True' or 'False'
  def display_active
    active? ? 'True' : 'False'
  end  

  def self.create_basic
    BASIC.each {|b| find_or_create_by(identifing_name: b, 
                                      display_name: b.capitalize) }
  end
end