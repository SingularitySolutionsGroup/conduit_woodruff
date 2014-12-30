class CreateStepGroupsSchema < ActiveRecord::Migration
  def change
    create_table :step_groups do |t|
      t.string  :name
    end
  end
end
