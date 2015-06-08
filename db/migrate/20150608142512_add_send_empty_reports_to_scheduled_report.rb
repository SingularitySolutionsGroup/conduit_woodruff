class AddSendEmptyReportsToScheduledReport < ActiveRecord::Migration
  def change
    add_column :scheduled_reports, :send_empty_reports, :string
  end
end
