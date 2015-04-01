class AddFormSubmissionIdToAnonymousFormSubmission < ActiveRecord::Migration
  def change
    add_column :anonymous_form_submissions, :form_submission_id, :integer
  end
end
