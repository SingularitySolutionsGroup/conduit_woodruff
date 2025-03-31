class CreateUserApplicationHistories < ActiveRecord::Migration
  def change
    create_table :user_application_histories do |t|
      t.integer :user_application_id
      t.integer :master_application_id
      t.integer :user_id
      t.text :application_stamp
      t.hstore :data

      t.timestamps
    end
  end
end
