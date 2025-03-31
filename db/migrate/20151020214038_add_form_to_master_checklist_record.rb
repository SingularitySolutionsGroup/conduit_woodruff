class AddFormToMasterChecklistRecord < ActiveRecord::Migration
  def change
    add_column :checklists, :form, :string
  end
end
