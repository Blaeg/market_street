class DropBrand < ActiveRecord::Migration
  def change
  	drop_table :brands
  	remove_column :products, :brand_id  	
  end
end
