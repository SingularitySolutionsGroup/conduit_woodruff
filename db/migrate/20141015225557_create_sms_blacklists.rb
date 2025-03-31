class CreateSmsBlacklists < ActiveRecord::Migration
  def change
    create_table :sms_blacklists do |t|
      t.integer :user_id
      t.string :phone

      t.timestamps
    end
  end
end
