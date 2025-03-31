class CreateEmailApiRequest < ActiveRecord::Migration
  def change
    create_table :email_api_requests do |t|
      t.text   :message_body
      t.string :sender_email
      t.text   :subject
      t.text   :recipient_emails
      t.timestamps
    end
  end
end
