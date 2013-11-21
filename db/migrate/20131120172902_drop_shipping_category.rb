class DropShippingCategory < ActiveRecord::Migration
  def change
  	drop_table :shipping_categories
  end
end
