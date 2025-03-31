class CreateGoogleAppointmentLogs < ActiveRecord::Migration
  def change
    create_table :google_appointment_logs do |t|

      t.timestamps
    end
  end
end
