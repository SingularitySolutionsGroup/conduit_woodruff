class AddTimestampsToStudentApplicationState < ActiveRecord::Migration

  def change
    add_column :student_application_states, :created_at, :datetime
    add_column :student_application_states, :updated_at, :datetime
  end

end
