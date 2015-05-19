class CreateLeadDataChangeLogs < ActiveRecord::Migration
  def change
    create_table :lead_data_change_logs do |t|
      t.text :changed_keys
      t.text :changed_new_data
      t.text :changed_original_data
      t.string :lead_id

      t.timestamps
    end
  end
end
