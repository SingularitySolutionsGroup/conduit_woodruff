class AddFirstNameAndLastNameToImportantFieldUpdate < ActiveRecord::Migration
  def change
    add_column :important_field_updates, :first_name, :string
    add_column :important_field_updates, :last_name, :string
  end
end
