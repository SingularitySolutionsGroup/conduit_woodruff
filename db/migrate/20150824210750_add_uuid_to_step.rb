class AddUuidToStep < ActiveRecord::Migration
  def change
    add_column :steps, :uuid, :string
  end
end
