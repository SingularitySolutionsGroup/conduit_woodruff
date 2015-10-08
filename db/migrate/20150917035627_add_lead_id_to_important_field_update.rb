class AddLeadIdToImportantFieldUpdate < ActiveRecord::Migration
  def change
    add_column :important_field_updates, :lead_id, :string
  end
end
