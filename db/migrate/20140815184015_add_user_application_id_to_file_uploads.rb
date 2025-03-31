class AddUserApplicationIdToFileUploads < ActiveRecord::Migration
  def change
    add_column :file_uploads, :user_application_id, :integer
  end
end
