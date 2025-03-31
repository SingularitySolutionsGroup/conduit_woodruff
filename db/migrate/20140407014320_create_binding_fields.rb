class CreateBindingFields < ActiveRecord::Migration
  def change
    create_table :binding_fields do |t|
      t.string :name

      t.timestamps
    end
  end
end
