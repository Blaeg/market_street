class DropShipmentCountFromOrder < ActiveRecord::Migration
  def change
  	remove_column :orders, :shipments_count
  end
end
