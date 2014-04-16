class AddExtraAccessToUsers < ActiveRecord::Migration
  def change
    add_column :users, :extra_access, :boolean, :default => false
  end
end
