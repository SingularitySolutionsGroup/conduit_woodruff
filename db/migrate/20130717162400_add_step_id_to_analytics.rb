class AddStepIdToAnalytics < ActiveRecord::Migration
  def change
    add_column :analytics, :step_id, :integer
  end
end
