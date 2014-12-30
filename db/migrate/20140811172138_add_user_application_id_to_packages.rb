class AddUserApplicationIdToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :user_application_id, :integer
  end
end
