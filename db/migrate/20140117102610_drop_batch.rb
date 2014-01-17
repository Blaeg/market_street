class DropBatch < ActiveRecord::Migration
  def change
  	drop_table :batches
  end
end
