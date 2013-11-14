class DealType < ActiveRecord::Base

  validates :name,            :presence => true

  has_many :deals
  TYPES = ['Buy X Get % off', 'Buy X Get $ off']

  def self.create_all
    TYPES.each {|x| find_or_create_by(name: x) }
  end
end
