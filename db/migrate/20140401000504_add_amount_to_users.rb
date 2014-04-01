class AddAmountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :amount, :decimal
  end
end
