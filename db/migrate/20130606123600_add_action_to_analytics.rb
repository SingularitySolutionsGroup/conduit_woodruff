class AddActionToAnalytics < ActiveRecord::Migration
  def change
    add_column :analytics, :action, :string
  end
end
