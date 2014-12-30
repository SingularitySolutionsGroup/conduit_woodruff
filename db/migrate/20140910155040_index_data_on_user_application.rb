class IndexDataOnUserApplication < ActiveRecord::Migration
  def change
    add_hstore_index :user_applications, :data
  end
end
