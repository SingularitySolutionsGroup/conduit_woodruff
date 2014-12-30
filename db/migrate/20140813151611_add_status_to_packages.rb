class AddStatusToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :status, :string
  end
end
