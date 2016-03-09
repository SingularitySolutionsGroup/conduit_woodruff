class AddStepAssociationDataToFileDownloads < ActiveRecord::Migration
  def change
    add_column :file_downloads, :step_association_data, :hstore
  end
end
