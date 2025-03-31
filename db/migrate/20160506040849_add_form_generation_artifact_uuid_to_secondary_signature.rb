class AddFormGenerationArtifactUuidToSecondarySignature < ActiveRecord::Migration
  def change
    add_column :secondary_signatures, :form_generation_artifact_uuid, :text
  end
end
