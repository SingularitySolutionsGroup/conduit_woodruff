class AddIsAccountActivatedToRefineryUsersSchema < ActiveRecord::Migration
  def change
    add_column :refinery_users, :is_account_activated, :string
  end
end
