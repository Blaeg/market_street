class AddRetailToVariant < ActiveRecord::Migration
  def change
    add_column :variants, :retail, :float
  end
end
