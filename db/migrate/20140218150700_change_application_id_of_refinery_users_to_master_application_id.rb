class ChangeApplicationIdOfRefineryUsersToMasterApplicationId < ActiveRecord::Migration
  def change
    rename_column :refinery_users, :application_id, :master_application_id
  end
end
