class AddAccountActivationIdToRefineryUsersSchema < ActiveRecord::Migration
  def change
    add_column :refinery_users, :account_activation_id, :string
  end
end
