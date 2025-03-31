class CreateStudentApplicationStatesSchema < ActiveRecord::Migration
  def change
    create_table :student_application_states do |t|
      t.integer :student_application_id
      t.integer :user_id
      t.string  :form_id
      t.string  :status
      t.string  :guid
    end
  end
end
