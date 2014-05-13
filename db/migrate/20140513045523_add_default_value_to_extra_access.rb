class AddDefaultValueToExtraAccess < ActiveRecord::Migration
  def up
    change_column :coupons, :extra_access, :boolean, :default => false
  end

  def down
    change_column :coupons, :extra_access, :boolean, :default => nil
  end
end
