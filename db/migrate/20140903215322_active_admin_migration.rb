class ActiveAdminMigration < ActiveRecord::Migration
  def self.up
  end
  
  def self.down
    drop_table :admin_users
  end
end
