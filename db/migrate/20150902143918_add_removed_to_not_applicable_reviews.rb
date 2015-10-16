class AddRemovedToNotApplicableReviews < ActiveRecord::Migration
  def change
    add_column :not_applicable_reviews, :removed_by_user_id, :integer
    add_column :not_applicable_reviews, :removed_at, :datetime
  end
end
