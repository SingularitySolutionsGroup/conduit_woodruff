class AddFormGenerationArtifactUuidToWalkIns < ActiveRecord::Migration
  def change
    add_column :walk_ins, :form_generation_artifact_uuid, :text
  end
end
