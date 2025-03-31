class AddApplicationIdToRefineryUsers < ActiveRecord::Migration
  def change
    add_column :refinery_users, :application_id, :int
  end
end
