class DropActiveAndCalculatedAtFromOrder < ActiveRecord::Migration
  def change
  	remove_column :orders, :coupon_id
  	remove_column :orders, :active
  	remove_column :orders, :calculated_at
  	add_column :orders, :tax_rate, :float, null: false, default: 0.0
  end
end
