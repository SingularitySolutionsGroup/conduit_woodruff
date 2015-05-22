class AddIndexesToStudentApplicationStates < ActiveRecord::Migration
  def change
    add_index :student_application_states, :step_id
    add_index :student_application_states, :user_id
    add_index :student_application_states, :user_application_id
    add_index :student_application_states, [:user_id, :user_application_id], name: 'user_id_and_app_id'
    add_index :student_application_states, :submission_id
    add_index :student_application_states, [:user_id, :step_id]
  end
end
