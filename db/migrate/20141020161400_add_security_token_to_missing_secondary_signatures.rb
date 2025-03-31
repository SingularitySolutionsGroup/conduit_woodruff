class AddSecurityTokenToMissingSecondarySignatures < ActiveRecord::Migration
  def change
    add_column :missing_secondary_signatures, :security_token, :string
  end
end
