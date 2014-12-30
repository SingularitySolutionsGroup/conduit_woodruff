class AddUserApplicationIdToFileDownloads < ActiveRecord::Migration
  def change
    add_column :file_downloads, :user_application_id, :integer
  end
end
