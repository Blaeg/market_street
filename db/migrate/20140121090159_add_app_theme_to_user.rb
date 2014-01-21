class AddAppThemeToUser < ActiveRecord::Migration
  def up
    add_column :users, :app_theme, :string, :default => 'application'
  end

  def down
    remove_column :users, :app_theme
  end
end
