class CreateOriginalFormDefinitionLogs < ActiveRecord::Migration
  def change
    create_table :original_form_definition_logs do |t|
      t.text :data
      t.integer :form_id
      t.integer :user_id
      t.string :slug

      t.timestamps
    end
  end
end
