class AddAvatarUrlToRefineryUser < ActiveRecord::Migration
  def change
    add_column :refinery_users, :avatar_url, :text
  end
end
