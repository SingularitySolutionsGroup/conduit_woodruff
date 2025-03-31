class AddUserIdToFileUploadsAndFileDownloads < ActiveRecord::Migration
  def change
    add_column :file_uploads,   :user_id, :integer
    add_column :file_downloads, :user_id, :integer
  end
end
