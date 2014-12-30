class CreateUserNotifications < ActiveRecord::Migration
  def change
    create_table :user_notifications do |t|
      t.integer :user_id
      t.integer :user_event_id
      t.integer :related_user_id

      t.timestamps
    end
  end
end
