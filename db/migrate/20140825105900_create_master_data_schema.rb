class CreateMasterDataSchema < ActiveRecord::Migration

  def change
    create_table :master_datas do |t|
      t.string  :key
      t.text    :value
      t.timestamps
    end
  end

end
