class CreateMasterApplicationSchema < ActiveRecord::Migration
  def change
    create_table :master_applications do |t|
      t.string  :name
      t.text    :application_stamp
      t.timestamps
    end
  end
end
