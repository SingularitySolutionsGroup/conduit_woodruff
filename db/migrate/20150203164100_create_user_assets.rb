class CreateUserAssets < ActiveRecord::Migration
  def change
    create_table :user_assets do |t|
      t.integer :user_id
      t.text    :filepicker_data
      t.hstore  :event_data
      t.timestamps
    end
  end
end
