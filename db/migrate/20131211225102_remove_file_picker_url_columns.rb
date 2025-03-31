class RemoveFilePickerUrlColumns < ActiveRecord::Migration
  def up
    remove_column :file_uploads, :filepicker_url
    remove_column :file_downloads, :filepicker_url

    add_column :file_uploads, :filepicker_data, :string
    add_column :file_downloads, :filepicker_data, :string
  end

  def down
    add_column :file_uploads, :filepicker_url, :string
    add_column :file_downloads, :filepicker_url, :string

    remove_column :file_uploads, :filepicker_data
    remove_column :file_downloads, :filepicker_data
  end
end
