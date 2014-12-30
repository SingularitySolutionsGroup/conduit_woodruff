class AddSearchableColumnsToHiveRecord < ActiveRecord::Migration
  def change
    add_column :hive_records, :first_name, :string
    add_column :hive_records, :last_name, :string
    add_column :hive_records, :email, :string
  end
end
