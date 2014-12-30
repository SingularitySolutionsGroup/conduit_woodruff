class AddAgentNameToHiveRecord < ActiveRecord::Migration
  def change
    add_column :hive_records, :agent_name, :string
    sql = '
      CREATE OR REPLACE FUNCTION hive_record_create_or_update() RETURNS TRIGGER AS $hive_record_create_or_update$
          BEGIN
        update hive_records set
            first_name = (NEW.data->\'first_name\'),
            last_name = (NEW.data->\'last_name\'),
            email = (NEW.data->\'email\'),
            agent_name = (NEW.data->\'agent_name\')
          where (hive_records.id = NEW.id);
              RETURN NULL;
          END;
      $hive_record_create_or_update$ LANGUAGE plpgsql;
    '
    ActiveRecord::Base.connection.execute sql
  end
end
