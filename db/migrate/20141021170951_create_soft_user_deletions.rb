class CreateSoftUserDeletions < ActiveRecord::Migration
  def change
    create_table :soft_user_deletions do |t|
      t.integer :user_id
      t.integer :by_user_id
      t.text :data

      t.timestamps
    end
  end
end
