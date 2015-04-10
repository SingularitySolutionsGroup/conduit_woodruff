class AddResultToGoogleAppointmentLog < ActiveRecord::Migration
  def change
    add_column :google_appointment_logs, :result, :string
  end
end
