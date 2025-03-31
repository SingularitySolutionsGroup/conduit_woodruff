class AddTemplateToCollectionSchema < ActiveRecord::Migration
  def change
    add_column :collections, :template, :text
  end
end
