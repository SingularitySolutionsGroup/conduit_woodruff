class CreateUserApplicationEventLog < ActiveRecord::Migration
  def change
    create_table :user_application_event_logs do |t|
      t.integer :user_id
      t.integer :user_application_id
      t.integer :user_id_of_modifier
      t.string  :username_of_modifier
      t.text    :pre_update_application_stamp
      t.text    :post_update_application_stamp
      t.hstore  :data
      t.timestamps
    end
  end
end
