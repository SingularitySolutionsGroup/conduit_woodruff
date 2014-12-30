class UpdateNoteColumnsToText < ActiveRecord::Migration
  def change
    change_column :notes, :note, :text
  end
end
