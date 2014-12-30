class IndexHiveRecords < ActiveRecord::Migration
  def change
    add_hstore_index :hive_records, :data
  end
end
