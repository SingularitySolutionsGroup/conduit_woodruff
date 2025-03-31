class AddStepIdToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :step_id, :integer
  end
end
