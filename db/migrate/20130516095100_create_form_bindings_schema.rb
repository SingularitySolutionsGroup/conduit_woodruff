class CreateFormBindingsSchema < ActiveRecord::Migration
  def change
    create_table :form_bindings do |t|
      t.string :form_id
      t.string :question_id
      t.string :control_type
      t.string  :hive_field_name
      t.string  :hive_form_item_name
    end
  end
end