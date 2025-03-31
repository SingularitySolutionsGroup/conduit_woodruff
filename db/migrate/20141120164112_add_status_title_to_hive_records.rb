class AddStatusTitleToHiveRecords < ActiveRecord::Migration
  def change
    add_column :hive_records, :status_title, :string
  end
end
