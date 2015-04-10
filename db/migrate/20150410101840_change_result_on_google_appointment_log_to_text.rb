class ChangeResultOnGoogleAppointmentLogToText < ActiveRecord::Migration
  def change
    change_column :google_appointment_logs, :result, :text
  end
end
