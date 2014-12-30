class AddStepNameAndStepDetailsToStudentApplicationStateSchema < ActiveRecord::Migration
  def change
    add_column :student_application_states, :step_name, :text
    add_column :student_application_states, :step_details, :text
  end
end
