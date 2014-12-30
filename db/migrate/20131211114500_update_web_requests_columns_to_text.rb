class UpdateWebRequestsColumnsToText < ActiveRecord::Migration
  def change
    change_column :web_requests, :user_agent, :text
    change_column :web_requests, :referer, :text
  end
end
