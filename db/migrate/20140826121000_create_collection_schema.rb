class CreateCollectionSchema < ActiveRecord::Migration

  def change
    create_table :collections do |t|
      t.string  :name
      t.timestamps
    end
  end

end
