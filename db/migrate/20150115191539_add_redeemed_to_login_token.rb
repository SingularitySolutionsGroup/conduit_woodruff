class AddRedeemedToLoginToken < ActiveRecord::Migration
  def change
    add_column :login_tokens, :redeemed, :boolean
  end
end
