class AddDataToStudentApplicationState < ActiveRecord::Migration
  def change
    add_column :student_application_states, :data, :text
  end
end
