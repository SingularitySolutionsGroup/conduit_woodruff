class AddNameToScheduledReports < ActiveRecord::Migration
  def change
    add_column :scheduled_reports, :name, :string
  end
end
