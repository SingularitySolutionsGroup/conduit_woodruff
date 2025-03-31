class AddTagsToFileUploads < ActiveRecord::Migration
  def change
    add_column :file_uploads, :tags, :string
  end
end
