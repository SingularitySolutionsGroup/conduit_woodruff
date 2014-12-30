class AddTagsToFileDownloads < ActiveRecord::Migration
  def change
    add_column :file_downloads, :tags, :string
  end
end
