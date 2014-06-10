class AddKanbanIdToKanbanMilestones < ActiveRecord::Migration
  def change
    add_column :kanban_milestones, :kanban_id, :integer
    add_index :kanban_milestones, :kanban_id
  end
end
