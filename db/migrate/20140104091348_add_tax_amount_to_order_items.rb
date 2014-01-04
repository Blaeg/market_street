class AddTaxAmountToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :tax_amount, :float
    rename_column :order_items, :total, :total_amount
    remove_column :order_items, :tax_rate_id
    remove_column :order_items, :shipment_id
    add_column :order_items, :shipped_at, :datetime
    add_column :order_items, :delivered_at, :datetime
  end
end
