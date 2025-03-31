class CreateLeadEntries < ActiveRecord::Migration
  def change
    create_table :lead_entries do |t|
      t.text :input
      t.text :form
      t.text :request
      t.integer :user_id
      t.string :lead_id
      t.string :match

      t.timestamps
    end
  end
end
