class Coupon < ActiveRecord::Base
  validates :code, :price, :message, presence: true
  validates :code, format: { with: /\A[A-Z\d]+\z/, message: "must be capitalized" }
  validates :code, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
