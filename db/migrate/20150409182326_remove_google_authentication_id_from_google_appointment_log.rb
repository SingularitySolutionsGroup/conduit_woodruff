class RemoveGoogleAuthenticationIdFromGoogleAppointmentLog < ActiveRecord::Migration
  def change
    remove_column :google_appointment_logs, :google_authentication_id
  end
end
