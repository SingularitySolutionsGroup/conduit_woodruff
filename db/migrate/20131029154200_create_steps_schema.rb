class CreateStepsSchema < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.belongs_to  :step_group
      t.string      :name
      t.string      :form_id
      t.boolean     :is_skippable
      t.string      :button_text
      t.string      :type
      t.string      :error_text
      t.string      :tag
      t.boolean     :should_send_notifications
      t.string      :details
    end
  end
end
