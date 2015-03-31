class CreateAnonymousFormSubmissions < ActiveRecord::Migration
  def change
    create_table :anonymous_form_submissions do |t|
      t.text     :passthrough_data
      t.text     :form
      t.text     :input
      t.boolean  :completed
      t.string   :slug
      t.string   :name
      t.integer  :form_id
      t.timestamps
    end
  end
end
