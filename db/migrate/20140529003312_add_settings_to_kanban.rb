class AddSettingsToKanban < ActiveRecord::Migration
  def up
    add_column :kanbans, :settings, :hstore
  end

  def down
    remove_column :kanbans, :settings
  end
end
