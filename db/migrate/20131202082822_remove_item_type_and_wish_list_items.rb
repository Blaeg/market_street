class RemoveItemTypeAndWishListItems < ActiveRecord::Migration
  def change  	
  	remove_column :cart_items, :user_id
  	remove_column :cart_items, :item_type_id
  	remove_column :carts, :customer_id
  	drop_table :item_types
  end
end
