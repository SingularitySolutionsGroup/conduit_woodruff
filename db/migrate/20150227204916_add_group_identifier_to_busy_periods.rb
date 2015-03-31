class AddGroupIdentifierToBusyPeriods < ActiveRecord::Migration
  def change
    add_column :busy_periods, :group_identifier, :string
  end
end
