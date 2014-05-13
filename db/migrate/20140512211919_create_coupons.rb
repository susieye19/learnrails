class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :code
      t.integer :price
      t.string :message

      t.timestamps
    end
  end
end
