class Prototype < ActiveRecord::Base

  has_many :products
  has_many :prototype_properties
  has_many :properties,          :through => :prototype_properties

  validates :name, :presence => true, :length => { :maximum => 255 }

  accepts_nested_attributes_for :properties, :prototype_properties

  PROTOTYPES = ['Table', 'Chair', 'Rug', 'Art', 'Lamp']

  def self.create_all
    PROTOTYPES.each do |t|
      find_or_create_by(:name => t, :active => true)
    end
  end
end
