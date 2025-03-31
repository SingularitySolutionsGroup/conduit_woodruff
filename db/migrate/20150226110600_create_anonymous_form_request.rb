class CreateAnonymousFormRequest < ActiveRecord::Migration
  def change
    create_table :anonymous_form_requests do |t|
      t.text     :passthrough_data
      t.string   :slug
      t.integer  :form_id
      t.integer  :form_submission_id
      t.timestamps
    end
  end
end
