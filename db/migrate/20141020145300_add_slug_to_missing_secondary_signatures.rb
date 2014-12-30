class AddSlugToMissingSecondarySignatures < ActiveRecord::Migration
  def change
    add_column :missing_secondary_signatures, :slug, :string
  end
end
