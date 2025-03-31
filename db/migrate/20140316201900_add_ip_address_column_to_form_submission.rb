class AddIpAddressColumnToFormSubmission < ActiveRecord::Migration
  def change
    add_column :form_submissions, :ip_address, :string
  end
end
