class AddMoreIndexesToUserNotifications < ActiveRecord::Migration
  def change
    add_index :user_notifications, :created_at, order: { created_at: :desc }, name: 'user_notifications_created_at_in_desc'
  end
end
