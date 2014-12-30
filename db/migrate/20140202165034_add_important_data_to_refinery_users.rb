class AddImportantDataToRefineryUsers < ActiveRecord::Migration
  def change
    add_column :refinery_users, :important_data, :text
  end
end
