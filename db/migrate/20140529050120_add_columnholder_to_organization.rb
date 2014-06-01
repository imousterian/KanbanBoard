class AddColumnholderToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :columnholder, :string
  end
end
