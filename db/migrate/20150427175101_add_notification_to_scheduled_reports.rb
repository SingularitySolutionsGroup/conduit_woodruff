class AddNotificationToScheduledReports < ActiveRecord::Migration
  def change
    add_column :scheduled_reports, :notification, :string
  end
end
