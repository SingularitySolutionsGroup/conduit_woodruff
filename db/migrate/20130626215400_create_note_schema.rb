class CreateNoteSchema < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :note
      t.string :user_id
      t.string :username
      t.datetime :created_at
    end
  end
end
