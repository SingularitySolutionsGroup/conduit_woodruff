class CreateUnsubscribeRequests < ActiveRecord::Migration
  def change
    create_table :unsubscribe_requests do |t|
      t.string :email

      t.timestamps
    end
  end
end
