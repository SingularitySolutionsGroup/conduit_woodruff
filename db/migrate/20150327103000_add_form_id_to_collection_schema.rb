class AddFormIdToCollectionSchema < ActiveRecord::Migration
  def change
    add_column :collections, :form_id, :integer
  end
end
