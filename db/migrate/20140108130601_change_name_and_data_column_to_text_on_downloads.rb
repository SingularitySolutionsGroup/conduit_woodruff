class ChangeNameAndDataColumnToTextOnDownloads < ActiveRecord::Migration
  def change
    change_column :file_downloads, :name, :text
    change_column :file_downloads, :filepicker_data, :text
  end
end
