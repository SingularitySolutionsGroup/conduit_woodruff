class CreateGoogleAuthentications < ActiveRecord::Migration
  def change
    create_table :google_authentications do |t|
      t.integer :user_id
      t.text :data

      t.timestamps
    end
  end
end
