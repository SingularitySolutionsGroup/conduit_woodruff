class AddDataToUserApplication < ActiveRecord::Migration
  def change
    add_column :user_applications, :data, :hstore
  end
end
