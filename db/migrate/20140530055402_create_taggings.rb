class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
        t.belongs_to :task, index: true
        t.belongs_to :kanban, index: true
    end
  end
end
