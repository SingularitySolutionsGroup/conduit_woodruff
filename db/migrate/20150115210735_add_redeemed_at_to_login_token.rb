class AddRedeemedAtToLoginToken < ActiveRecord::Migration
  def change
    add_column :login_tokens, :redeemed_at, :datetime
  end
end
