class AddNotifiedAtToPotentialSecondarySignatureSigner < ActiveRecord::Migration
  def change
    add_column :potential_secondary_signature_signers, :notified_at, :datetime
  end
end
