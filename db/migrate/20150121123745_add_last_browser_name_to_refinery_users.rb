class AddLastBrowserNameToRefineryUsers < ActiveRecord::Migration
  def change
    add_column :refinery_users, :last_browser_name, :string
  end
end
