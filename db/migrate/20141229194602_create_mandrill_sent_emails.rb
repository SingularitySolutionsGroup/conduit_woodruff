class CreateMandrillSentEmails < ActiveRecord::Migration
  def change
    create_table :mandrill_sent_emails do |t|
      t.text :request
      t.text :response
      t.boolean :successful
      t.string :template_id

      t.timestamps
    end
  end
end
