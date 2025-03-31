class CreateLoginTokens < ActiveRecord::Migration
  def change
    create_table :login_tokens do |t|
      t.string :token

      t.timestamps
    end
  end
end
