class AddReplaceTagColumnsToFormSubmission < ActiveRecord::Migration
  def change
    add_column :form_submissions, :replace_tags, :text
    add_column :form_submissions, :replace_tag_data, :text
  end
end
