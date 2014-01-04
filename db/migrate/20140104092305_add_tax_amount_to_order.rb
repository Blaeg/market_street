class AddTaxAmountToOrder < ActiveRecord::Migration
  def change
  	rename_column :orders, :credited_amount, :credit_amount
    add_column :orders, :shipped_at, :datetime
    add_column :orders, :shipping_amount, :float
    add_column :orders, :tax_amount, :float    
    add_column :orders, :total_amount, :float    
    remove_column :orders, :shipped
  end
end
