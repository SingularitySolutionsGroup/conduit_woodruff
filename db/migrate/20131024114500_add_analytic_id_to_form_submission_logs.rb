class AddAnalyticIdToFormSubmissionLogs < ActiveRecord::Migration
  def change
    add_column :form_submission_logs, :analytic_id, :integer
  end
end
