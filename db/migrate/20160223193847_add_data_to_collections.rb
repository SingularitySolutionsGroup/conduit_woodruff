class AddDataToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :data, :hstore
  end
end
