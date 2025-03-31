class ChangeUserAssetEventdataColumnToText < ActiveRecord::Migration
  def change
    change_column :user_assets, :event_data, :text
  end
end
