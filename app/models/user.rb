class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :stripe_card_token

  has_many :questions, dependent: :destroy
  validates :name, presence: true

  def save_with_payment
    if valid?
      Stripe.api_key = ENV["STRIPE_API_KEY"]
      token = stripe_card_token

      if coupon.blank?
        amount = 14900
        self.extra_access = true
      else
        Coupon.all.each do |c|
          if coupon.upcase == c.code.upcase
            amount = c.price
            self.extra_access = c.extra_access
          end
        end
      end

      if amount > 0
        charge = Stripe::Charge.create(
          :amount => amount,
          :currency => "usd",
          :card => token,
          :description => "Charge for #{email}"
        )
      end

      self.amount = amount/100.0
      save!
    end
  rescue Stripe::CardError => e
    errors.add :base, "There was a problem with your credit card."
    self.stripe_card_token = nil
    self.coupon = nil
    false
  rescue Stripe::InvalidRequestError => e
    errors.add :base, "#{e.message}"
    self.stripe_card_token = nil
    self.coupon = nil
    false
  end
end