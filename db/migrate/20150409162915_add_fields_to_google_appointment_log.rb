class AddFieldsToGoogleAppointmentLog < ActiveRecord::Migration
  def change
    add_column :google_appointment_logs, :available_appointment, :text
    add_column :google_appointment_logs, :event, :text
    add_column :google_appointment_logs, :google_calendar_id, :string
    add_column :google_appointment_logs, :user_id, :integer
    add_column :google_appointment_logs, :user_application_id, :integer
    add_column :google_appointment_logs, :google_authentication_id, :integer
  end
end
