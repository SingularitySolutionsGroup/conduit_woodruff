class CreateWebRequests < ActiveRecord::Migration
  def change
    create_table :web_requests do |t|
      t.string :controller
      t.string :action
      t.integer :user_id
      t.text :request
      t.text :params
      t.string :ip_address
      t.string :user_agent
      t.string :referer

      t.timestamps
    end
  end
end
