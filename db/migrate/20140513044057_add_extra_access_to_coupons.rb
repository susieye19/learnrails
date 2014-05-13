class AddExtraAccessToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :extra_access, :boolean
  end
end
