class CreateActiveAdminComments < ActiveRecord::Migration
  def self.up
  end
  
  def self.down
    drop_table :active_admin_comments
    end
  end
end