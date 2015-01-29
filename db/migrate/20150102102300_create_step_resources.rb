class CreateStepResources < ActiveRecord::Migration
  def change
    create_table :step_resources do |t|
      t.integer  :master_application_id
      t.integer  :step_id
      t.text     :filepicker_data
      t.text     :notes
      t.text     :content
      t.boolean  :completed
      t.string   :name
      t.timestamps
    end
  end
end
