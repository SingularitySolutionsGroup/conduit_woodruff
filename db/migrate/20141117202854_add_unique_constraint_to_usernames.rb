class AddUniqueConstraintToUsernames < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE refinery_users ADD CONSTRAINT refinery_users_unique_username UNIQUE (username);"
  end

  def self.down
    execute "ALTER TABLE refinery_users DROP CONSTRAINT refinery_users_unique_username;"
  end
end
