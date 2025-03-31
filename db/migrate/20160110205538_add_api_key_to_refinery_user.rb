class AddApiKeyToRefineryUser < ActiveRecord::Migration
  def change
    add_column :refinery_users, :api_key, :string
  end
end
