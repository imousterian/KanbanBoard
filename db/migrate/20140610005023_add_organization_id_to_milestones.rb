class AddOrganizationIdToMilestones < ActiveRecord::Migration
  def change
    add_column :milestones, :organization_id, :integer
    add_index :milestones, :organization_id
  end
end
