class CreateApplicationsRefineryUsersSchema < ActiveRecord::Migration
  def change
    create_table :applications_refinery_users do |t|
      t.integer     :master_application_id
      t.integer     :user_id
      t.text        :application_stamp
      t.timestamps
    end
  end
end
