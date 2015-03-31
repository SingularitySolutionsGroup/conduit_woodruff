class AddVerifiedAndVerifiedAtToVerifiedEmails < ActiveRecord::Migration
  def change
    add_column :verification_emails, :verified, :boolean
    add_column :verification_emails, :verified_at, :datetime
  end
end
