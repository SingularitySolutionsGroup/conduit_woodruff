class AddDefaultStepToSteps < ActiveRecord::Migration
  def change
    add_column :steps, :default_step, :bool
  end
end
