class AddCompletedAtToWebRequests < ActiveRecord::Migration
  def change
    add_column :web_requests, :completed_at, :time
  end
end
