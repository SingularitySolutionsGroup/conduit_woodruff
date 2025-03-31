class CreateFormSubmissionsSchema < ActiveRecord::Migration
  def change
    create_table :form_submissions do |t|
      t.text    :form_name
      t.integer :form_id
      t.integer :user_id
      t.integer :user_application_id
      t.text    :form
      t.text    :input
      t.timestamps
    end
  end
end
