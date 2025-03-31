class AddTagsToForms < ActiveRecord::Migration
  def change
    add_column :forms, :tags, :text
  end
end
