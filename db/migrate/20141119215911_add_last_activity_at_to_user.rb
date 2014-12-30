class AddLastActivityAtToUser < ActiveRecord::Migration
  def change
    add_column :refinery_users, :last_activity_at, :datetime
  end
end
