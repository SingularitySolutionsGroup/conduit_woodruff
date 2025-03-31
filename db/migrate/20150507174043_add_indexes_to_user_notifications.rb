class AddIndexesToUserNotifications < ActiveRecord::Migration
  def change
    add_index :user_notifications, :user_id
    add_index :user_notifications, :created_at
  end
end
