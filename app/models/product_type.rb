class ProductType < ActiveRecord::Base
  acts_as_nested_set  #:order => "name"
  has_many :products, dependent: :restrict_with_exception

  validates :name,    :presence => true, :length => { :maximum => 255 }

  FEATURED_TYPE_ID = 1

  TYPES = ['Table', 'Chair', 'Rug', 'Art', 'Lamp']

  def self.create_all
    TYPES.each do |t|
      find_or_create_by(:name => t, :active => true)
    end
  end
end
