class RemoveFormIdFromFormGenerationArtifacts < ActiveRecord::Migration
  def change
    remove_column :form_generation_artifacts, :form_id
  end
end
