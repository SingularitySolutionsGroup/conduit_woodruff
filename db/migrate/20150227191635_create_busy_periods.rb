class CreateBusyPeriods < ActiveRecord::Migration
  def change
    create_table :busy_periods do |t|
      t.datetime :from
      t.datetime :to
      t.integer :user_id
      t.text :data

      t.timestamps
    end
  end
end
