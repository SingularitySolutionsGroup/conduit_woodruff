class CreateSchoolSchema < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.text    :name
      t.text    :ipeds_id
      t.text    :street
      t.text    :street2
      t.text    :city
      t.text    :state
      t.text    :zip
      t.text    :school_type
      t.timestamps
    end
  end
end
