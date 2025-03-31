class AddFilterToScheduledReports < ActiveRecord::Migration
  def change
    add_column :scheduled_reports, :filter, :string
  end
end
