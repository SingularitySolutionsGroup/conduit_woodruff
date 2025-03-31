class AddLeadIdIndexToHiveRecords < ActiveRecord::Migration
  def change
    add_index :hive_records, :lead_id
  end
end
