class CreateIntegrationRequest < ActiveRecord::Migration
  def change
    create_table :integration_requests do |t|
      t.string :method
      t.text :data

      t.timestamps
    end
  end
end
