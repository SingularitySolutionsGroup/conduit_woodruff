class CreateSidekiqJobBackups < ActiveRecord::Migration
  def change
    create_table :sidekiq_job_backups do |t|
      t.text :data

      t.timestamps
    end
  end
end
