class AddAgentFieldsToUser < ActiveRecord::Migration

  def change
    add_column :refinery_users, :assigned_agent_email, :string
    add_column :refinery_users, :assigned_agent_id, :string
    add_column :refinery_users, :assigned_agent_name, :string
    add_column :refinery_users, :assigned_agent_group_id, :string
    add_column :refinery_users, :assigned_agent_group_name, :string
  end

end
