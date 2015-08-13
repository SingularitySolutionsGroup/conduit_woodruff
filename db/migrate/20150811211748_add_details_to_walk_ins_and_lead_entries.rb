class AddDetailsToWalkInsAndLeadEntries < ActiveRecord::Migration
  def change
    add_column :walk_ins, :details, :text
    add_column :lead_entries, :details, :text
  end
end
