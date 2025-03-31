class AddSequenceToStepGroupAndStepSchemas < ActiveRecord::Migration
  def change
    add_column :step_groups, :sequence, :integer
    add_column :steps, :sequence, :integer
  end
end
