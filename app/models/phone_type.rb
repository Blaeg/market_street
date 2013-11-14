class PhoneType < ActiveRecord::Base
  has_many :phones

  validates :name, :presence => true,       :length => { :maximum => 25 }

  # Type of possible phones, used in dropdowns and seed values
  NAMES = ['Cell', 'Home', 'Work', 'Other']

  def self.create_all
    NAMES.each {|x| find_or_create_by(name: x) }
  end
end
