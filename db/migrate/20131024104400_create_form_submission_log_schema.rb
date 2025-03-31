class CreateFormSubmissionLogSchema < ActiveRecord::Migration
  def change
    create_table :form_submission_logs do |t|
      t.text     :params
      t.string   :form_id
      t.integer  :step_id
      t.integer  :user_id
      t.integer  :student_application_state_id
      t.string   :hive_lead_id
      t.boolean  :successful
      t.timestamps
    end
  end
end