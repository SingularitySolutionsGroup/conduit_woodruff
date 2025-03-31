class CreateCustomStudentChecklistItems < ActiveRecord::Migration
  def change
    create_table :custom_student_checklist_items do |t|
      t.integer :user_id
      t.integer :user_application_id
      t.string :checklist_key
      t.string :key
      t.integer :creator_user_id

      t.timestamps
    end
  end
end
