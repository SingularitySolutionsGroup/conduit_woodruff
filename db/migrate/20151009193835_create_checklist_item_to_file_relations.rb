class CreateChecklistItemToFileRelations < ActiveRecord::Migration
  def change
    create_table :checklist_item_to_file_relations do |t|
      t.string :key
      t.integer :user_id
      t.integer :user_application_id
      t.string :relater_user_id
      t.string :related_to_key

      t.timestamps
    end
  end
end
