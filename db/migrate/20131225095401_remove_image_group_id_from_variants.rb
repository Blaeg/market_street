class RemoveImageGroupIdFromVariants < ActiveRecord::Migration
  def change
  	remove_column :variants, :image_group_id
  end
end
