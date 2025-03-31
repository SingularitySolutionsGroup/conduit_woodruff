class AddTitleToFileUploadsAndFileDownloads < ActiveRecord::Migration
  def change
    add_column :file_uploads,   :title, :string
    add_column :file_downloads, :title, :string
  end
end
