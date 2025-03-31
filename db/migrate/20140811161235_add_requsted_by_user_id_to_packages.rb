class AddRequstedByUserIdToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :requested_by_user_id, :integer
  end
end
