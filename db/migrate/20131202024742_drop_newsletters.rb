class DropNewsletters < ActiveRecord::Migration
  def change
  	drop_table :newsletters
  end
end
