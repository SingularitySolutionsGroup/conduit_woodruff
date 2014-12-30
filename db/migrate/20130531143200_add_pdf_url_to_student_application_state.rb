class AddPdfUrlToStudentApplicationState < ActiveRecord::Migration

  def change
    add_column :student_application_states, :pdf_url, :string
  end

end
