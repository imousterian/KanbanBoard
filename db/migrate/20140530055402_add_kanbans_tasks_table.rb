class AddKanbansTasksTable < ActiveRecord::Migration
  def change
    create_table :kanbans_tasks do |t|
        t.integer :kanban_id
        t.integer :task_id
    end
  end
end
