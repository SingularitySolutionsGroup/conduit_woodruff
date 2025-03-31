class AddUserApplicationIdToStudentApplicationState < ActiveRecord::Migration
  def change
    add_column :student_application_states, :user_application_id, :integer
  end
end
