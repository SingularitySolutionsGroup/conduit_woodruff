class RenameApplicationsRefineryUsersSchema < ActiveRecord::Migration
  def change
    rename_table :applications_refinery_users, :user_applications
  end
end
