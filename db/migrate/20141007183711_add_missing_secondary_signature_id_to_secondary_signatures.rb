class AddMissingSecondarySignatureIdToSecondarySignatures < ActiveRecord::Migration
  def change
    add_column :secondary_signatures, :missing_secondary_signature_id, :integer
  end
end
