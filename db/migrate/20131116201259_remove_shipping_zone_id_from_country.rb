class RemoveShippingZoneIdFromCountry < ActiveRecord::Migration
  def change
  	remove_column :countries, :shipping_zone_id
  end
end
