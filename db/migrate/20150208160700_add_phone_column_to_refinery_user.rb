class AddPhoneColumnToRefineryUser < ActiveRecord::Migration
  def change
    add_column :refinery_users, :phone, :string
  end
end
