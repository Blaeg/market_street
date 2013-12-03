class DropNewsletters < ActiveRecord::Migration
  def change
  	drop_table :newsletters
  	drop_table :users_newsletters
  end
end
