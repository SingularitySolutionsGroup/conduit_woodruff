class AddUserIdToLoginToken < ActiveRecord::Migration
  def change
    add_column :login_tokens, :user_id, :integer
  end
end
