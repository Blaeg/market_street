class RemoveActiveFromCart < ActiveRecord::Migration
  def change
  	remove_column :cart_items, :active
  end
end
