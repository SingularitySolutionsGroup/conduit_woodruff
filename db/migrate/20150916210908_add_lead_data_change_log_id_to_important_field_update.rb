class AddLeadDataChangeLogIdToImportantFieldUpdate < ActiveRecord::Migration
  def change
    add_column :important_field_updates, :lead_data_change_log_id, :integer
  end
end
