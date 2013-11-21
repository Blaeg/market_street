class AddShippingMethodIdToProduct < ActiveRecord::Migration
  def change
    add_column :products, :shipping_method_id, :integer
  end
end
