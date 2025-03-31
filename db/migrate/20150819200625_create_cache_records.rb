class CreateCacheRecords < ActiveRecord::Migration
  def change
    create_table :cache_records do |t|
      t.string :key
      t.text :data

      t.timestamps
    end
  end
end
