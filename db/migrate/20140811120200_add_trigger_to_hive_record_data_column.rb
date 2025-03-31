class AddTriggerToHiveRecordDataColumn < ActiveRecord::Migration
  def change
    sql = '
      CREATE OR REPLACE FUNCTION hive_record_create_or_update() RETURNS TRIGGER AS $hive_record_create_or_update$
          BEGIN
        update hive_records set
            first_name = (NEW.data->\'first_name\'),
            last_name = (NEW.data->\'last_name\'),
            email = (NEW.data->\'email\')
          where (hive_records.id = NEW.id);
              RETURN NULL;
          END;
      $hive_record_create_or_update$ LANGUAGE plpgsql;
    '
    ActiveRecord::Base.connection.execute sql

    sql ='
      CREATE TRIGGER on_hive_record_create_or_update
        AFTER INSERT OR UPDATE OF data ON hive_records
            FOR EACH ROW EXECUTE PROCEDURE hive_record_create_or_update();
    '
    ActiveRecord::Base.connection.execute sql
  end
end
