class AddUsesDefaultApplicationToUserApplications < ActiveRecord::Migration
  def change
    add_column :user_applications, :uses_default_application, :boolean
  end
end
