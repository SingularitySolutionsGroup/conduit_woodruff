class CreateFormMigrationLogSchema < ActiveRecord::Migration

  def change
    create_table :form_migration_logs do |t|
      t.integer :form_id
      t.text    :name
      t.text    :tags
      t.text    :data
      t.timestamps
    end
  end

end
