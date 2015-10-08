class AddOrderToMissingSecondarySignature < ActiveRecord::Migration
  def change
    add_column :missing_secondary_signatures, :order, :integer
  end
end
