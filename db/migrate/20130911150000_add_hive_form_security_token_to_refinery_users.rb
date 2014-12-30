class AddHiveFormSecurityTokenToRefineryUsers < ActiveRecord::Migration
  def change
    add_column :refinery_users, :hive_form_security_token, :string
  end
end