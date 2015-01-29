class CreateMandrillWebhookMessages < ActiveRecord::Migration
  def change
    create_table :mandrill_webhook_messages do |t|
      t.integer :integration_request_id
      t.text :data
      t.text :user_event_ids

      t.timestamps
    end
  end
end
