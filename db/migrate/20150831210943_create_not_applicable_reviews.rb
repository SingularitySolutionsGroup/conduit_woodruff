class CreateNotApplicableReviews < ActiveRecord::Migration
  def change
    create_table :not_applicable_reviews do |t|
      t.integer :user_id
      t.string :key
      t.integer :reviewer_user_id
      t.string :checklist_key

      t.timestamps
    end
  end
end
