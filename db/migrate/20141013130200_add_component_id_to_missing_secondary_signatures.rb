class AddComponentIdToMissingSecondarySignatures < ActiveRecord::Migration
  def change
    add_column :missing_secondary_signatures, :component_id, :integer
  end
end
