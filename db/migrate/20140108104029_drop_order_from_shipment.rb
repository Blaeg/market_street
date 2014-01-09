class DropOrderFromShipment < ActiveRecord::Migration
  def change
  	remove_column :shipments, :order_id
  end
end
