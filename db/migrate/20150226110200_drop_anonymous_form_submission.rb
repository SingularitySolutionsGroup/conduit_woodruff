class DropAnonymousFormSubmission < ActiveRecord::Migration
  def change
    drop_table :anonymous_form_submissions
  end
end
