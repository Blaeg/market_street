class AddCouponIdToCartAndOrder < ActiveRecord::Migration
  def change
  	add_column :carts, :coupon_id, :integer
  	add_column :orders, :coupon_id, :integer
  end
end
