class AddListViewDataToCollection < ActiveRecord::Migration
  def change
    add_column :collections, :list_view_data, :text
  end
end
