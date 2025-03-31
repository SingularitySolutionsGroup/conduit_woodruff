class AddStandardizedCellPhoneToRefineryUsers < ActiveRecord::Migration
  def change
    add_column :refinery_users, :standardized_cell_phone, :string
  end
end
