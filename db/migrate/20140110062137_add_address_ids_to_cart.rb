class AddAddressIdsToCart < ActiveRecord::Migration
  def change
    add_column :carts, :bill_address_id, :integer
    add_column :carts, :ship_address_id, :integer
  end
end
