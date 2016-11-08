class AddFieldToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_users, :name, :string
    add_column :admin_users, :title, :string
    add_column :admin_users, :role, :string
  end
end
