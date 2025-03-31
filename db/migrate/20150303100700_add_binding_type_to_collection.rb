class AddBindingTypeToCollection < ActiveRecord::Migration
  def change
    add_column :collections, :binding_type, :string
  end
end
