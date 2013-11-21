class RemoveShippingCategory < ActiveRecord::Migration
  def change
  	remove_column :shipping_rates, :shipping_category_id
  	remove_column :products, :shipping_category_id  
  end
end
