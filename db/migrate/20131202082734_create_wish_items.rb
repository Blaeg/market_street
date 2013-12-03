class CreateWishItems < ActiveRecord::Migration
  def change
    create_table :wish_items do |t|
      t.integer :user_id
      t.integer :variant_id

      t.timestamps
    end
  end
end
