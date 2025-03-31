class AddSpecialTypeToUserTags < ActiveRecord::Migration
  def change
    add_column :user_tags, :special_type, :string
  end
end
