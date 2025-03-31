class CreateIncrementingIntegers < ActiveRecord::Migration
  def change
    create_table :incrementing_integers do |t|

      t.timestamps
    end
  end
end
