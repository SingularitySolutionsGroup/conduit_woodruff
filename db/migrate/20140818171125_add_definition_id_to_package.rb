class AddDefinitionIdToPackage < ActiveRecord::Migration
  def change
    add_column :packages, :definition_id, :string
  end
end
