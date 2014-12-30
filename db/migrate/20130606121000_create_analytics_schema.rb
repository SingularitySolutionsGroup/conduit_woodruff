class CreateAnalyticsSchema < ActiveRecord::Migration
  def change
    create_table :analytics do |t|
      t.datetime :create_date
      t.integer :student_application_id
      t.integer :user_id
      t.string  :form_id
      t.string  :user_agent
    end
  end
end
