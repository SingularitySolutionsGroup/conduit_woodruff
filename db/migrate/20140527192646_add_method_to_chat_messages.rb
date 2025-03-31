class AddMethodToChatMessages < ActiveRecord::Migration
  def change
    add_column :chat_messages, :method, :string
  end
end
