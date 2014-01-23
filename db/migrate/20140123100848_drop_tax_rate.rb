class DropTaxRate < ActiveRecord::Migration
  def change
  	drop_table :tax_rates
  	drop_table :tax_statuses  	
  end
end
