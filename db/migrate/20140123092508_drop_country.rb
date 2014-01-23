class DropCountry < ActiveRecord::Migration
  def change
  	remove_column :addresses, :country_code
  	remove_column :tax_rates, :country_code
  	remove_column :states, :country_code
  	drop_table :countries
		add_column :addresses, :country_code, :string
		add_column :states, :country_code, :string
  end
end