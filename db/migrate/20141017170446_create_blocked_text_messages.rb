class CreateBlockedTextMessages < ActiveRecord::Migration
  def change
    create_table :blocked_text_messages do |t|
      t.string :to
      t.string :from
      t.text :message
      t.integer :user_id

      t.timestamps
    end
  end
end
