class CreateExternalIdColumnOnUser < ActiveRecord::Migration
  def change
    add_column :refinery_users, :external_id, :string
  end
end