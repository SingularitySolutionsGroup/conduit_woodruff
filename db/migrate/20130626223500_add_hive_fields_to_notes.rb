class AddHiveFieldsToNotes < ActiveRecord::Migration

  def change
    add_column :notes, :hive_client_id, :string
    add_column :notes, :hive_lead_id,   :string
  end

end
