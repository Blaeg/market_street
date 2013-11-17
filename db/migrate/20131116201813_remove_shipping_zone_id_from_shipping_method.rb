class RemoveShippingZoneIdFromShippingMethod < ActiveRecord::Migration
  def change
  	remove_column :shipping_methods, :shipping_zone_id
  end
end
