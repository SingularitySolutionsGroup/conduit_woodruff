class CreateHiveRecords < ActiveRecord::Migration
  def change
    create_table :hive_records do |t|
      t.string :lead_id
      t.hstore :data

      t.timestamps
    end
  end
end
