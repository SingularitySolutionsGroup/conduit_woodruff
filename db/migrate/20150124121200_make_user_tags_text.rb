class MakeUserTagsText < ActiveRecord::Migration
  def change
    change_column :user_tags, :name, :text
  end
end
