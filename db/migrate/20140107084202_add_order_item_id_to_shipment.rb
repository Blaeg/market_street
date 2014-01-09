class AddOrderItemIdToShipment < ActiveRecord::Migration
  def change
    add_column :shipments, :order_item_id, :integer
  end
end
