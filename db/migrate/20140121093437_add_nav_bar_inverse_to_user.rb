class AddNavBarInverseToUser < ActiveRecord::Migration
  def change
    add_column :users, :nav_bar_inverse, :boolean, :default => true
  end
end
