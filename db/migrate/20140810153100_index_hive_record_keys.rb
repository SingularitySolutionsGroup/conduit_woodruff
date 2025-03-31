class IndexHiveRecordKeys < ActiveRecord::Migration
  def change
    sql = 'CREATE INDEX "hive_records_data_email_idx" ON hive_records USING btree ((data->\'email\'))'
    ActiveRecord::Base.connection.execute sql

    sql = 'CREATE INDEX "hive_records_data_first_name_idx" ON hive_records USING btree ((data->\'first_name\'))'
    ActiveRecord::Base.connection.execute sql

    sql = 'CREATE INDEX "hive_records_data_last_name_idx" ON hive_records USING btree ((data->\'last_name\'))'
    ActiveRecord::Base.connection.execute sql
  end
end
