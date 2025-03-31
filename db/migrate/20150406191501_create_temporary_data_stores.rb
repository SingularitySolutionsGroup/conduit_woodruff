class CreateTemporaryDataStores < ActiveRecord::Migration
  def change
    create_table :temporary_data_stores do |t|
      t.string :key
      t.datetime :expire_at
      t.text :data

      t.timestamps
    end
  end
end
