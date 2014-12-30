class CreateClientSideLogs < ActiveRecord::Migration
  def change
    create_table :client_side_logs do |t|
      t.string :description
      t.string :data
      t.datetime :created_at
    end
  end
end
