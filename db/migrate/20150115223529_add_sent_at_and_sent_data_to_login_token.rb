class AddSentAtAndSentDataToLoginToken < ActiveRecord::Migration
  def change
    add_column :login_tokens, :sent_at, :datetime
    add_column :login_tokens, :sent_data, :text
  end
end
