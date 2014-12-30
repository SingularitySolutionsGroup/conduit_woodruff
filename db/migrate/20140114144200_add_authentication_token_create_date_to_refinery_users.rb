class AddAuthenticationTokenCreateDateToRefineryUsers < ActiveRecord::Migration
  def change
    add_column :refinery_users, :activation_token_create_date, :datetime
  end
end
