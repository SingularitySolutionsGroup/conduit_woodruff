class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :key
      t.integer :user_id
      t.integer :user_application_id
      t.integer :reviewer_user_id

      t.timestamps
    end
  end
end
