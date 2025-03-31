class AddResultsToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :result, :text
  end
end
