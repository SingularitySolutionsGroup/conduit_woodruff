class AddUserApplicationIdToUserEvents < ActiveRecord::Migration
  def change
    add_column :user_events, :user_application_id, :integer
  end
end
