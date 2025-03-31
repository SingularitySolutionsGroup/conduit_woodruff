class AddSubmissionIdColumnToStudentApplicationStates < ActiveRecord::Migration
  def change
    add_column :student_application_states, :submission_id, :string
  end
end