class AddEtsydemoAccessToUsers < ActiveRecord::Migration
  def change
    add_column :users, :etsydemo_access, :boolean, :default => false
  end
end
