class CreateMasterApplicationHistoricalRecords < ActiveRecord::Migration
  def change
    create_table :master_application_historical_records do |t|
      t.string :old_name
      t.string :new_name
      t.text :old_application_stamp
      t.text :new_application_stamp

      t.timestamps
    end
  end
end
