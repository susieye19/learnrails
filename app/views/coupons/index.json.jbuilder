json.array!(@coupons) do |coupon|
  json.extract! coupon, :id, :code, :price, :message
  json.url coupon_url(coupon, format: :json)
end
