class AddMetaInfoClientSideLogging < ActiveRecord::Migration
  def change
    add_column :client_side_logs, :ip_address, :string
  end
end