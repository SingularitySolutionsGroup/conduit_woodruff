class CreateSecondarySignatures < ActiveRecord::Migration
  def change
    create_table :secondary_signatures do |t|
      t.text :form_name
      t.integer :form_id
      t.integer :user_id
      t.integer :user_application_id
      t.text :form
      t.text :input
      t.text :replace_tags
      t.text :replace_tag_data
      t.string :ip_address
      t.integer :step_id
      t.integer :primary_user_application_id
      t.integer :primary_user_id
      t.integer :primary_form_submission_id

      t.timestamps
    end
  end
end
