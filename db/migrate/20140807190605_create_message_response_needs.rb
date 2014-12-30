class CreateMessageResponseNeeds < ActiveRecord::Migration
  def change
    create_table :message_response_needs do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
