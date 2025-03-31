class CreateMissingSecondarySignatures < ActiveRecord::Migration
  def change
    create_table :missing_secondary_signatures do |t|
      t.integer :primary_user_application_id
      t.integer :primary_user_id
      t.integer :primary_form_submission_id

      t.timestamps
    end
  end
end
