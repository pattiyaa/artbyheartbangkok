class CreateAdminUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_users do |t|
      t.string :email
      t.string :password
      t.datetime :createdate
      t.datetime :modifydate
      
      t.timestamps
    end
  end
end
