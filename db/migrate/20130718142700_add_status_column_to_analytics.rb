class AddStatusColumnToAnalytics < ActiveRecord::Migration
  def change
    add_column :analytics, :status, :text
  end
end