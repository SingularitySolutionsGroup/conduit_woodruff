class AddDataToChatMessages < ActiveRecord::Migration
  def change
    add_column :chat_messages, :data, :text
  end
end
