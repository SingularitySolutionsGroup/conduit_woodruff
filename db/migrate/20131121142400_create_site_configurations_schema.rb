class CreateSiteConfigurationsSchema < ActiveRecord::Migration
  def change
    create_table :site_configurations do |t|
      t.string      :name
      t.string      :value
    end
  end
end