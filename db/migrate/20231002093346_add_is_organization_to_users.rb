class AddIsOrganizationToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_organization, :boolean
  end
end
