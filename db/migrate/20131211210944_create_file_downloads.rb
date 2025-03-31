class CreateFileDownloads < ActiveRecord::Migration
  def change
    create_table :file_downloads do |t|
      t.string :name
      t.string :filepicker_url

      t.timestamps
    end
  end
end
