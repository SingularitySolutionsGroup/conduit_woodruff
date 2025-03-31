class CreateVerificationEmails < ActiveRecord::Migration
  def change
    create_table :verification_emails do |t|
      t.integer :user_id
      t.string :url
      t.string :email

      t.timestamps
    end
  end
end
