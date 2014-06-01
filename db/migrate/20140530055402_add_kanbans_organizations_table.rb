class AddKanbansOrganizationsTable < ActiveRecord::Migration
  def change
    create_table :kanbans_organizations do |t|
        t.integer :kanban_id
        t.integer :organization_id
    end
  end
end
