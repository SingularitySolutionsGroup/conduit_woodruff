class CreateImportantFieldUpdates < ActiveRecord::Migration
  def change
    create_table :important_field_updates do |t|
      t.string :field

      t.timestamps
    end
  end
end
