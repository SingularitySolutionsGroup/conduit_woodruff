class ChangeCachedReportNameColumnToText < ActiveRecord::Migration
  def change
    change_column :cached_reports, :name, :text
  end
end