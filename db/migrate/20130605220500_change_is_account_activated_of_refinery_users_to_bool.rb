class ChangeIsAccountActivatedOfRefineryUsersToBool < ActiveRecord::Migration
  def change
    remove_column :refinery_users, :is_account_activated
    add_column :refinery_users, :is_account_activated, :boolean
  end
end
