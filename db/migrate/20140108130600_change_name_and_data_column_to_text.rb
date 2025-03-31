class ChangeNameAndDataColumnToText < ActiveRecord::Migration
  def change
    change_column :file_uploads, :name, :text
    change_column :file_uploads, :filepicker_data, :text
  end
end
