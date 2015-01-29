class AddByUserIdToLoginToken < ActiveRecord::Migration
  def change
    add_column :login_tokens, :by_user_id, :integer
  end
end
