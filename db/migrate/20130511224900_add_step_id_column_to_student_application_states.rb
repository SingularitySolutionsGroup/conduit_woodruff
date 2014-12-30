class AddStepIdColumnToStudentApplicationStates < ActiveRecord::Migration
  def change
    add_column :student_application_states, :step_id, :integer
  end
end