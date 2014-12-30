class CreateSentTextMessages < ActiveRecord::Migration
  def change
    create_table :sent_text_messages do |t|
      t.string :to
      t.string :from
      t.text :message
      t.integer :user_id

      t.timestamps
    end
  end
end
