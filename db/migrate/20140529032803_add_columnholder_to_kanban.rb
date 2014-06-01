class AddColumnholderToKanban < ActiveRecord::Migration
  def change
    add_column :kanbans, :columnholder, :string
  end
end
