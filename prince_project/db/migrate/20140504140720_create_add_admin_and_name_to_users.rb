class CreateAddAdminAndNameToUsers < ActiveRecord::Migration
  def change
    create_table :add_admin_and_name_to_users do |t|
      t.string :name
      t.boolean :admin

      t.timestamps
    end
  end
end
