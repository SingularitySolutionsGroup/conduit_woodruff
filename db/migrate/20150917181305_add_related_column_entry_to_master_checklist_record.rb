class AddRelatedColumnEntryToMasterChecklistRecord < ActiveRecord::Migration
  def change
    add_column :checklists, :related_column_entry, :string
  end
end
