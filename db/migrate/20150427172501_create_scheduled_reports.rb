class CreateScheduledReports < ActiveRecord::Migration
  def change
    create_table :scheduled_reports do |t|
      t.string :to
      t.string :subject

      t.timestamps
    end
  end
end
