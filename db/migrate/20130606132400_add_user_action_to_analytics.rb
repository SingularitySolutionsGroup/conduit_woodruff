class AddUserActionToAnalytics < ActiveRecord::Migration
  def change
    remove_column :analytics, :action
    add_column :analytics, :user_action, :string
  end
end
