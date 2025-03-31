class AddSentStatusToChatMessage < ActiveRecord::Migration
  def change
    add_column :chat_messages, :sent_status, :string
  end
end
