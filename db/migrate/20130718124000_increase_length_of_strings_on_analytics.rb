class IncreaseLengthOfStringsOnAnalytics < ActiveRecord::Migration
  def change
    change_column :analytics, :user_agent, :text
    change_column :analytics, :user_action, :text
  end
end
