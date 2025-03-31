class CreatePotentialSecondarySignatureSigners < ActiveRecord::Migration
  def change
    create_table :potential_secondary_signature_signers do |t|
      t.string :email
      t.integer :missing_secondary_signature_id
      t.string :slug

      t.timestamps
    end
  end
end
