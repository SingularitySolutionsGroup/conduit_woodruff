class AddOldValueAndNewValueToImportantFieldUpdates < ActiveRecord::Migration
  def change
    add_column :important_field_updates, :old_value, :string
    add_column :important_field_updates, :new_value, :string
  end
end
