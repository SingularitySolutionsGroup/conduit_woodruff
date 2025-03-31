class AddNameToChatMessages < ActiveRecord::Migration
  def change
    add_column :chat_messages, :name, :string
  end
end
