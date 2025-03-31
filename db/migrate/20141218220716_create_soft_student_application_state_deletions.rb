class CreateSoftStudentApplicationStateDeletions < ActiveRecord::Migration
  def change
    create_table :soft_student_application_state_deletions do |t|
      t.integer :student_application_state_id
      t.integer :by_userid
      t.text :data

      t.timestamps
    end
  end
end
