class CreateCachedReport < ActiveRecord::Migration
  def change
    create_table :cached_reports do |t|
      t.string :name
      t.text :data
      t.timestamps
    end
  end
end
