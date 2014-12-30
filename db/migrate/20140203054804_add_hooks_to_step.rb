class AddHooksToStep < ActiveRecord::Migration
  def change
    add_column :steps, :hooks, :text
  end
end
