class AddLastUserAgentToRefineryUsers < ActiveRecord::Migration
  def change
    add_column :refinery_users, :last_user_agent, :string
  end
end
