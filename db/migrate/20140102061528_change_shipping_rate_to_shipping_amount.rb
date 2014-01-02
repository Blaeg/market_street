class ChangeShippingRateToShippingAmount < ActiveRecord::Migration
  def change
  	remove_column :order_items, :shipping_rate_id
  	add_column :order_items, :shipping_amount, :float, :default => 0.0
  end
end
