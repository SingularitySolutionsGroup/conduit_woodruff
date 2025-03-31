class AddAccountActivationIdDateRefineryUser < ActiveRecord::Migration
  def change
    add_column :refinery_users, :account_activation_id_stamp_date, :datetime
  end
end
