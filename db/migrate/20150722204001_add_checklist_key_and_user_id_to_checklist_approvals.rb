class AddChecklistKeyAndUserIdToChecklistApprovals < ActiveRecord::Migration
  def change
    add_column :checklist_approvals, :checklist_key, :string
    add_column :checklist_approvals, :user_id, :integer
  end
end
