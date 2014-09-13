class AddTaskIdToMilestones < ActiveRecord::Migration
  def change
    add_column :milestones, :task_id, :integer
    add_index :milestones, :task_id
  end
end
