class AddStepIdToFormSubmission < ActiveRecord::Migration
  def change
    add_column :form_submissions, :step_id, :integer
  end
end
