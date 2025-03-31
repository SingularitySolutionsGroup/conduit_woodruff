class AddIndexesToUserEvents < ActiveRecord::Migration
  def change
    add_index :user_events, :user_id
    add_index :user_events, :event_type
    add_index :user_events, [:user_id, :event_type]
  end
end
