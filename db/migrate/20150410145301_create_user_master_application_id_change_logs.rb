class CreateUserMasterApplicationIdChangeLogs < ActiveRecord::Migration
  def change
    create_table :user_master_application_id_change_logs do |t|
      t.integer :user_id
      t.integer :from_master_application_id
      t.integer :to_master_application_id
      t.integer :admin_user_id
      t.string :admin_name

      t.timestamps
    end
  end
end
