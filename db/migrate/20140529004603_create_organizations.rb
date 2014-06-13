class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.hstore :progress
      t.string :content

      t.timestamps
    end
  end
end
