class AddColumnholderToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :org_columnholder, :string
  end
end
