class WishItem < ActiveRecord::Base
	belongs_to :user
	belongs_to :variant
end
