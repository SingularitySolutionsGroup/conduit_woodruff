class RenameStudentApplicationStatusGuidToExternalId < ActiveRecord::Migration
  def change
    rename_column :student_application_states, :guid, :external_id
  end
end