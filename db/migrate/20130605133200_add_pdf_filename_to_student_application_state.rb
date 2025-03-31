class AddPdfFilenameToStudentApplicationState < ActiveRecord::Migration

  def change
    add_column :student_application_states, :pdf_filename, :string
    remove_column :student_application_states, :pdf_url
  end

end
