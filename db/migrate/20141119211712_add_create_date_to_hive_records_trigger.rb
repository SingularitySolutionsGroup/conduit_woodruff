class AddCreateDateToHiveRecordsTrigger < ActiveRecord::Migration
  def change
    sql = '
      CREATE OR REPLACE FUNCTION hive_record_create_or_update() RETURNS TRIGGER AS $hive_record_create_or_update$
          BEGIN
        update hive_records set
            first_name = (NEW.data->\'first_name\'),
            last_name = (NEW.data->\'last_name\'),
            email = (NEW.data->\'email\'),
            create_date = to_timestamp((NEW.data->\'create_date\'), \'MM/DD/YYYY HH24:MI:SS\')
          where (hive_records.id = NEW.id);
              RETURN NULL;
          END;
      $hive_record_create_or_update$ LANGUAGE plpgsql;
    '
    ActiveRecord::Base.connection.execute sql

    sql = '
        update hive_records set
            first_name = (hive_records.data->\'first_name\'),
            last_name = (hive_records.data->\'last_name\'),
            email = (hive_records.data->\'email\'),
            create_date = to_timestamp((hive_records.data->\'create_date\'), \'MM/DD/YYYY HH24:MI:SS\')
    '
    ActiveRecord::Base.connection.execute sql
  end
end
