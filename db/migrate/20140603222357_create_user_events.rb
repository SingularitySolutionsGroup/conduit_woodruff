class CreateUserEvents < ActiveRecord::Migration
  def change
    create_table :user_events do |t|
      t.integer :user_id
      t.string :event_type
      t.string :message
      t.text :data

      t.timestamps
    end
  end
end
