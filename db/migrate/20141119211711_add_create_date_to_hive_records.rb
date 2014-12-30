class AddCreateDateToHiveRecords < ActiveRecord::Migration
  def change
    add_column :hive_records, :create_date, :datetime
  end
end
