class AddFieldsMasterApplicationHistoricalRecords < ActiveRecord::Migration
  def change
    add_column :master_application_historical_records, :user_id, :integer
    add_column :master_application_historical_records, :master_application_id, :integer
  end
end
