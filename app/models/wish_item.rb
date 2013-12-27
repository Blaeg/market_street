class WishItem < ActiveRecord::Base
	belongs_to :user
	belongs_to :variant
	attr_accessible :variant_id, :user_id

	validates_presence_of :user_id
	validates_presence_of :variant_id
end
