class CreateChecklistApprovals < ActiveRecord::Migration
  def change
    create_table :checklist_approvals do |t|
      t.integer :approved_by_user_id

      t.timestamps
    end
  end
end
