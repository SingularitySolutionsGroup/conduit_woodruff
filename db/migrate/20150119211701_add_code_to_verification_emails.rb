class AddCodeToVerificationEmails < ActiveRecord::Migration
  def change
    add_column :verification_emails, :code, :string
  end
end
