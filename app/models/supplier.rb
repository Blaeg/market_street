# == Schema Information
#
# Table name: suppliers
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)     not null
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Supplier < ActiveRecord::Base
  has_many :variant_suppliers
  has_many :variants, :through => :variant_suppliers
  has_many :phones

  validates :name, :presence => true, :length => { :maximum => 255 }
  validates :email, :email => true, :length => { :maximum => 255 }  
end
