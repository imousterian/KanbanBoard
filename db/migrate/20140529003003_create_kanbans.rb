class CreateKanbans < ActiveRecord::Migration
  def change
    create_table :kanbans do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
    add_index :kanbans, [:user_id, :created_at]
  end
end
