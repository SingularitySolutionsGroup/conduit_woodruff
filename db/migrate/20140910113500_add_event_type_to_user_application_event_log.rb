class AddEventTypeToUserApplicationEventLog < ActiveRecord::Migration
  def change
    add_column :user_application_event_logs, :event_type, :string
  end
end
