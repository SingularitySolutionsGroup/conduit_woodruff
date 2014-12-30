class AddMessageToUserNotifications < ActiveRecord::Migration
  def change
    add_column :user_notifications, :message, :text
  end
end
