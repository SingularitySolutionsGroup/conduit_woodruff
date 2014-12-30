class CreateChatMessages < ActiveRecord::Migration
  def change
    create_table :chat_messages do |t|
      t.text :message
      t.integer :user_id
      t.integer :user_application_id
      t.integer :master_application_id
      t.string :source

      t.timestamps
    end
  end
end
