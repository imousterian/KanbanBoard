class CreateKanbanMilestones < ActiveRecord::Migration
  def change
    create_table :kanban_milestones do |t|
      t.string :kms_name

      t.timestamps
    end
  end
end
