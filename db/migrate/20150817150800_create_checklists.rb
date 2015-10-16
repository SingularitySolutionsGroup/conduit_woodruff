class CreateChecklists < ActiveRecord::Migration
  def change
    create_table :checklists do |t|
      t.text :name
      t.text :items
      t.timestamps
    end
  end
end
