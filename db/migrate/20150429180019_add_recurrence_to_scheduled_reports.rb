class AddRecurrenceToScheduledReports < ActiveRecord::Migration
  def change
    add_column :scheduled_reports, :next_recurrence, :datetime
    add_column :scheduled_reports, :tickle_expression, :string
  end
end
