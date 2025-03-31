class AddStepIdToChecklistItemToFileRelation < ActiveRecord::Migration
  def change
    add_column :checklist_item_to_file_relations, :step_id, :integer
  end
end
