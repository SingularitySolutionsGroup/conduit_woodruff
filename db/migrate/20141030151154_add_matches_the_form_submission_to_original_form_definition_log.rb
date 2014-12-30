class AddMatchesTheFormSubmissionToOriginalFormDefinitionLog < ActiveRecord::Migration
  def change
    add_column :original_form_definition_logs, :matches_the_form_submission, :boolean
  end
end
