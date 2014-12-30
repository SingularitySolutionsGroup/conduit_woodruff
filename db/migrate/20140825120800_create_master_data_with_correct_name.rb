class CreateMasterDataWithCorrectName < ActiveRecord::Migration

  def change
    drop_table :master_datas
    create_table :master_data do |t|
      t.string  :key
      t.text    :value
      t.timestamps
    end
  end

end
