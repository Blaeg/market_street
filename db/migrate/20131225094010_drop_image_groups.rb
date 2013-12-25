class DropImageGroups < ActiveRecord::Migration
  def change
  	drop_table :image_groups
  end
end
