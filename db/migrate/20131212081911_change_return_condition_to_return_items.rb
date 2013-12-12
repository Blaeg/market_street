class ChangeReturnConditionToReturnItems < ActiveRecord::Migration
  def change
  	remove_column :return_items, :return_condition_id
  	remove_column :return_items, :return_reason_id 

  	add_column :return_items, :return_condition, :string
  	add_column :return_items, :return_reason, :string 

  	drop_table :return_conditions
  	drop_table :return_reasons
  end
end
