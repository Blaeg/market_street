class DropPhoneIdFromAddress < ActiveRecord::Migration
  def change
  	remove_column :addresses, :phone_id
  	remove_column :addresses, :state_name
  	drop_table :phones

  	rename_column :addresses, :alternative_phone, :phone
  	rename_column :addresses, :active, :is_active
  	rename_column :addresses, :default, :ship_default
  	rename_column :addresses, :bill_default, :bill_default
  end
end
