class ChangeUserAssetEventdataColumnName < ActiveRecord::Migration
  def change
    rename_column :user_assets, :event_data, :data
  end
end
