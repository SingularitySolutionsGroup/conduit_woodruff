class CreateLeadDataStamps < ActiveRecord::Migration
  def change
    create_table :lead_data_stamps do |t|
      t.integer :user_application_id
      t.integer :user_id
      t.text :data
      t.string :key

      t.timestamps
    end
  end
end
