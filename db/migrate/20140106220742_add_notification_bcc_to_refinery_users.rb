class AddNotificationBccToRefineryUsers < ActiveRecord::Migration
  def change
    add_column :refinery_users, :notification_bcc, :text
  end
end
