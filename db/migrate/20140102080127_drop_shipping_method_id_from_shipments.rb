class DropShippingMethodIdFromShipments < ActiveRecord::Migration
  def change
  	remove_column :shipments, :shipping_method_id
  end
end
