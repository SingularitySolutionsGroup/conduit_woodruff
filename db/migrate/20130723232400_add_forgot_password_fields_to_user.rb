class AddForgotPasswordFieldsToUser < ActiveRecord::Migration
  def change
    add_column :refinery_users, :forgot_password_id, :string
    add_column :refinery_users, :forgot_password_date,  :datetime
  end
end
