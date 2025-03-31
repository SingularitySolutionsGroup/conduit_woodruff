class AddExpiresAtToLoginToken < ActiveRecord::Migration
  def change
    add_column :login_tokens, :expires_at, :datetime
  end
end
