class AddBryanSpecificTriggerToHiveRecordDataColumn < ActiveRecord::Migration
  def change
    sql = '
      CREATE OR REPLACE FUNCTION bryan_specific_hive_record_create_or_update() RETURNS TRIGGER AS $bryan_specific_hive_record_create_or_update$
          BEGIN
        update hive_records set
            status_title = (NEW.data->\'status_title\')
          where (hive_records.id = NEW.id);
              RETURN NULL;
          END;
      $bryan_specific_hive_record_create_or_update$ LANGUAGE plpgsql;
    '
    ActiveRecord::Base.connection.execute sql

    sql ='
      CREATE TRIGGER on_bryan_specific_hive_record_create_or_update
        AFTER INSERT OR UPDATE OF data ON hive_records
            FOR EACH ROW EXECUTE PROCEDURE bryan_specific_hive_record_create_or_update();
    '
    ActiveRecord::Base.connection.execute sql
  end
end
