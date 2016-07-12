class CreateFormGenerationArtifacts < ActiveRecord::Migration
  def change
    create_table :form_generation_artifacts do |t|
      t.integer :user_id
      t.integer :form_id
      t.text :uuid
      t.text :form
      t.text :input
      t.text :relevant_data

      t.timestamps
    end
  end
end
