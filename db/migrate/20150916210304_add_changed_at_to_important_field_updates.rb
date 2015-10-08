class AddChangedAtToImportantFieldUpdates < ActiveRecord::Migration
  def change
    add_column :important_field_updates, :changed_at, :datetime
  end
end
