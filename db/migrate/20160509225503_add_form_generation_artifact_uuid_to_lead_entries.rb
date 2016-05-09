class AddFormGenerationArtifactUuidToLeadEntries < ActiveRecord::Migration
  def change
    add_column :lead_entries, :form_generation_artifact_uuid, :text
  end
end
