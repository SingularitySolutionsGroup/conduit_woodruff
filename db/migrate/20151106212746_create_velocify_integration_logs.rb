class CreateVelocifyIntegrationLogs < ActiveRecord::Migration
  def change
    create_table :velocify_integration_logs do |t|
      t.string :method
      t.text :data
      t.string :lead_id

      t.timestamps
    end
  end
end
