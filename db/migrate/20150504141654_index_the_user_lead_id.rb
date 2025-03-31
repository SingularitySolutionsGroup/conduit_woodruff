class IndexTheUserLeadId < ActiveRecord::Migration
  def change
    add_index :refinery_users, :hive_lead_id
  end
end
