class AddActivationTokensToRefineryUsers < ActiveRecord::Migration
  def change
    add_column :refinery_users, :activation_token1, :text
    add_column :refinery_users, :activation_token2, :text
    add_column :refinery_users, :activation_token3, :text
  end
end
