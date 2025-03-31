class CreateTrackedEvents < ActiveRecord::Migration
  def change
    create_table :tracked_events do |t|
      t.string :lead_id
      t.string :event_name
      t.text :data

      t.timestamps
    end
  end
end
