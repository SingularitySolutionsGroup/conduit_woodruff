class CreateAssetImports < ActiveRecord::Migration
  def change
    create_table :asset_imports do |t|
      t.string    :created_by
      t.integer   :created_by_user_id
      t.string    :modified_by
      t.integer   :modified_by_user_id
      t.text      :name
      t.text      :content
      t.text      :notes
      t.text      :meta_data
      t.boolean   :is_complete
      t.timestamps
    end
  end
end
