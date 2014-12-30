class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.integer :user_id
      t.text :definition

      t.timestamps
    end
  end
end
