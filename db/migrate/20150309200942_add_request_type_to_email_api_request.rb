class AddRequestTypeToEmailApiRequest < ActiveRecord::Migration
  def change
    add_column :email_api_requests, :request_type, :string
  end
end
