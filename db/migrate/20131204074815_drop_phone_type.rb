class DropPhoneType < ActiveRecord::Migration
  def change
  	remove_column :addresses, :address_type_id
  	remove_column :deals, :deal_type_id
  	remove_column :phones, :phone_type_id
  	remove_column :referrals, :referral_type_id
  	remove_column :shipping_rates, :shipping_rate_type_id

  	add_column :addresses, :address_type, :string
  	add_column :deals, :deal_type, :string
  	add_column :phones, :phone_type, :string
  	add_column :shipping_rates, :shipping_rate_type, :string

  	drop_table :address_types
  	drop_table :deal_types
  	drop_table :phone_types
  	drop_table :referral_types
  	drop_table :shipping_rate_types
  end
end
