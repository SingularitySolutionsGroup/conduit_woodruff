class AddCompletedInToWebRequests < ActiveRecord::Migration
  def change
    add_column :web_requests, :completed_in, :integer
  end
end
