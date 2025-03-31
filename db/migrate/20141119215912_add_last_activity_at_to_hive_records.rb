class AddLastActivityAtToHiveRecords < ActiveRecord::Migration
  def change
    add_column :hive_records, :last_activity_at, :datetime
  end
end
