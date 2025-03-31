class AddPublicUrlToUserAsset < ActiveRecord::Migration

  def change
    add_column :user_assets, :public_url, :text
  end

end
