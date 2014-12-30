class AddRefineryUserIdToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :refinery_user_id, :integer
  end
end
