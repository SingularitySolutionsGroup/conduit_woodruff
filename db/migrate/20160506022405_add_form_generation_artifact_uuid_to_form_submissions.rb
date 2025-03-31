class AddFormGenerationArtifactUuidToFormSubmissions < ActiveRecord::Migration
  def change
    add_column :form_submissions, :form_generation_artifact_uuid, :text
  end
end
