class CreateFormHistoricalRecords < ActiveRecord::Migration
  def change
    create_table :form_historical_records do |t|
      t.integer :form_id
      t.integer :user_id
      t.string :name
      t.text :data
      t.text :tags

      t.timestamps
    end
  end
end
