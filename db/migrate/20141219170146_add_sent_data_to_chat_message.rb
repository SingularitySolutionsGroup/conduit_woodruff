class AddSentDataToChatMessage < ActiveRecord::Migration
  def change
    add_column :chat_messages, :sent_at, :datetime
    add_column :chat_messages, :sent_data, :text
  end
end
