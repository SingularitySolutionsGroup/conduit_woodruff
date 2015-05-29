class AddLastSentAtToScheduledReports < ActiveRecord::Migration
  def change
    add_column :scheduled_reports, :last_sent_at, :datetime
  end
end
