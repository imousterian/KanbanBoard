class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
        t.string :name
        t.string :content

        t.timestamps
    end
  end
end
