class CreateStudentChecklistItemDeletions < ActiveRecord::Migration
  def change
    create_table :student_checklist_item_deletions do |t|
      t.integer :user_id
      t.integer :user_application_id
      t.integer :checklist_key
      t.string :key

      t.timestamps
    end
  end
end
