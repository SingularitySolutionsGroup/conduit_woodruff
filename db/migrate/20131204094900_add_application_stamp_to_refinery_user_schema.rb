class AddApplicationStampToRefineryUserSchema < ActiveRecord::Migration
  def change
    add_column :refinery_users, :application_stamp, :text
  end
end
