class AddForcePasswordResetToRefineryUsers < ActiveRecord::Migration

  def change
    add_column :refinery_users, :force_password_reset, :boolean
  end

end
