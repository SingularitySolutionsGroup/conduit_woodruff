class AddGroupIdentifierToAvailableAppointments < ActiveRecord::Migration
  def change
    add_column :available_appointments, :group_identifier, :string
  end
end
