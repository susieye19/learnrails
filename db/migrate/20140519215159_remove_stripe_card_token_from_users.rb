class RemoveStripeCardTokenFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :stripe_card_token, :string
  end
end
