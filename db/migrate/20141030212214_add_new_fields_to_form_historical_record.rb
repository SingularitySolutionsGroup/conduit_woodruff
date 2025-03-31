class AddNewFieldsToFormHistoricalRecord < ActiveRecord::Migration
  def change
    add_column :form_historical_records, :new_name, :string
    add_column :form_historical_records, :new_data, :text
    add_column :form_historical_records, :new_tags, :text
  end
end
