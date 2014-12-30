class CreateLoginRecords < ActiveRecord::Migration
  def change
    create_table :login_records do |t|
      t.string :ip
      t.integer :user_id
      t.string :username

      t.timestamps
    end
  end
end
