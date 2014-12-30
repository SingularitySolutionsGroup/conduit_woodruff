class AddUserIdToTrackedEvents < ActiveRecord::Migration
  def change
    add_column :tracked_events, :user_id, :integer
  end
end
