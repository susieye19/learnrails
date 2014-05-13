def change
  create_table :coupons do |t|
    t.string :code
    t.string :discount

    t.timestamps
  end
end