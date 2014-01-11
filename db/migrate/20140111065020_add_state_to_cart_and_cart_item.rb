class AddStateToCartAndCartItem < ActiveRecord::Migration
  def change
  	add_column :carts, :is_active, :boolean, :default => true
  	add_column :cart_items, :is_active, :boolean, :default => true
  end
end