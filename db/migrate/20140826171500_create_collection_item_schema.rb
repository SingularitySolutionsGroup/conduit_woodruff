class CreateCollectionItemSchema < ActiveRecord::Migration

  def change
    create_table :collection_items do |t|
      t.string        :name
      t.text          :value
      t.integer       :collection_id
      t.timestamps
    end
  end

end
