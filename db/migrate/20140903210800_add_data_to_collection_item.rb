class AddDataToCollectionItem < ActiveRecord::Migration
  def change
    remove_column :collection_items, :value
    add_column :collection_items, :data, :hstore
  end
end
