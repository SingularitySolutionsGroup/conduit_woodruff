class AddFormSubmissionIdToOriginalFormDefinitionLog < ActiveRecord::Migration
  def change
    add_column :original_form_definition_logs, :form_submission_id, :integer
  end
end
