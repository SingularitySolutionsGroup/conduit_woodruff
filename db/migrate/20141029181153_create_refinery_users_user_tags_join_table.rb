class CreateRefineryUsersUserTagsJoinTable < ActiveRecord::Migration
  def change
    create_table :user_tags_users, id: false do |t|
      t.integer :user_id
      t.integer :user_tag_id
    end
  end
end
