class AddHiveFieldsToUser < ActiveRecord::Migration

  def change
    add_column :refinery_users, :hive_client_id, :string
    add_column :refinery_users, :hive_lead_id,   :string
  end

end
