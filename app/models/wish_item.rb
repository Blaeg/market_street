class WishItem < ActiveRecord::Base
	belongs_to :user
	belongs_to :variant
	
	validates_presence_of :user_id
	validates_presence_of :variant_id
end
