class AddReportIdToScheduledReports < ActiveRecord::Migration
  def change
    add_column :scheduled_reports, :report_id, :string
  end
end
