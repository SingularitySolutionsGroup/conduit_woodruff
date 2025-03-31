class AddMoreIndexesToHiveRecords < ActiveRecord::Migration
  def change
    add_index :hive_records, :first_name
    add_index :hive_records, :last_name
    add_index :hive_records, :email
    add_index :hive_records, :last_activity_at
  end
end
