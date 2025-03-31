class AddTagToCollectionSchema < ActiveRecord::Migration
  def change
    add_column :collections, :tag, :text
  end
end
